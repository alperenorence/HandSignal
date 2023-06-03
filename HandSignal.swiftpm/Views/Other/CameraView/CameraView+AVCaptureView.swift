//
//  CameraView+AVCaptureView.swift
//  
//
//  Created by Alperen Örence on 27.03.2023.
//

import AVFoundation
import SwiftUI

// MARK: - AVCaptureView

extension CameraView {
    struct AVCaptureView: UIViewRepresentable {

        // MARK: Properties

        @EnvironmentObject private var cameraManager: CameraManager
        @EnvironmentObject private var handPoseDetector: HandPoseDetector

        // MARK: Functions

        func makeUIView(context: Context) -> UIView {
            context.coordinator.makeUIView(with: cameraManager.captureSession)
        }

        func updateUIView(_ uiView: UIView, context: Context) {
            context.coordinator.updateFrame(with: uiView.frame.size)
        }

        func makeCoordinator() -> Coordinator {
            let coordinator: Coordinator = .init(handPoseDetector: handPoseDetector)
            coordinator.startOrientationTask()
            cameraManager.captureOutput.setSampleBufferDelegate(coordinator, queue: coordinator.queue)
            return coordinator
        }

        static func dismantleUIView(_ uiView: UIView, coordinator: Coordinator) {
            coordinator.stopOrientationTask()
        }
    }
}

// MARK: - AVCaptureView Coordinator

extension CameraView.AVCaptureView {
    @MainActor class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {

        // MARK: Properties

        let handPoseDetector: HandPoseDetector
        let queue: DispatchQueue = .init(
            label: "AVCaptureViewCoordinator",
            autoreleaseFrequency: .workItem
        )

        private var uiView: UIView? = nil
        private var capturePreview: AVCaptureVideoPreviewLayer? = nil
        private var orientationTask: Task<Void, Never>? = nil

        // MARK: Initializers

        init(handPoseDetector: HandPoseDetector) {
            self.handPoseDetector = handPoseDetector
        }

        // MARK: Functions

        nonisolated func captureOutput(
            _ output: AVCaptureOutput,
            didOutput sampleBuffer: CMSampleBuffer,
            from connection: AVCaptureConnection
        ) {
            guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

            handPoseDetector.onImageReceived(buffer: imageBuffer)

            guard let flippedBuffer = CIImage(cvImageBuffer: imageBuffer)
                .oriented(.upMirrored)
                .pixelBuffer else { return }

            handPoseDetector.onImageReceived(buffer: flippedBuffer)
        }

        func makeUIView(with session: AVCaptureSession) -> UIView {
            let uiView: UIView = .init()
            let capturePreview: AVCaptureVideoPreviewLayer = .init(session: session)

            capturePreview.videoGravity = .resizeAspectFill
            uiView.layer.addSublayer(capturePreview)

            self.uiView = uiView
            self.capturePreview = capturePreview

            return uiView
        }

        func updateFrame(with size: CGSize) {
            capturePreview?.frame.size = size
        }

        func startOrientationTask() {
            orientationTask = .init {
                UIDevice.current.beginGeneratingDeviceOrientationNotifications()

                let notifications = NotificationCenter.default
                    .notifications(named: UIDevice.orientationDidChangeNotification)
                    .compactMap({ $0.object as? UIDevice })

                for await device in notifications {
                    guard !Task.isCancelled else { return }
                    guard capturePreview?.connection?.isVideoOrientationSupported == true else { continue }

                    capturePreview?.connection?.videoOrientation = .init(rawValue: device.orientation.rawValue)!

                    try? await Task.sleep(for: .seconds(0.5))

                    if let uiView {
                        updateFrame(with: uiView.frame.size)
                    }
                }
            }
        }

        func stopOrientationTask() {
            UIDevice.current.endGeneratingDeviceOrientationNotifications()
            orientationTask?.cancel()
        }
    }
}
