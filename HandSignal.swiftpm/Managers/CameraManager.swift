//
//  CameraManager.swift
//  
//
//  Created by Alperen Örence on 27.03.2023.
//

import AVFoundation
import SwiftUI

// MARK: - CameraManager

@MainActor class CameraManager: ObservableObject {

    // MARK: Properties

    @Published private(set) var setupStatus: SetupStatus = .notStarted
    @Published private(set) var runStatus: RunStatus = .stopped
    @Published private(set) var currentCamera: AVCaptureDevice.Position? = nil

    let captureSession: AVCaptureSession = .init()
    let captureOutput: AVCaptureVideoDataOutput = .init()

    private var frontCamera: AVCaptureDeviceInput? = nil
    private var backCamera: AVCaptureDeviceInput? = nil
}

// MARK: - Publics

extension CameraManager {

    // MARK: Functions

    func setupCamera() async {
        guard setupStatus == .notStarted else { return }

        setupStatus = .loading

        let cameraStatus: Bool = await Task.detached {
            await AVCaptureDevice.requestAccess(for: .video)
        }.value

        guard cameraStatus else {
            setupStatus = .accessDenied
            return
        }

        guard await setupCapture() else {
            setupStatus = .failed
            return
        }

        setupStatus = .success
    }

    func startCapture() async {
        guard setupStatus == .success, runStatus == .stopped else { return }

        runStatus = .loading

        await Task.detached {
            self.captureSession.startRunning()
        }.value

        runStatus = .running
    }

    func stopCapture() async {
        guard setupStatus == .success, runStatus == .running else { return }

        runStatus = .loading

        await Task.detached {
            self.captureSession.stopRunning()
        }.value

        runStatus = .stopped
    }

    func switchCamera() {
        guard let frontCamera, let backCamera else { return }

        switch currentCamera {
        case .front:
            captureSession.removeInput(frontCamera)
            captureSession.addInput(backCamera)
            currentCamera = .back

        case .back:
            captureSession.removeInput(backCamera)
            captureSession.addInput(frontCamera)
            currentCamera = .front

        default:
            break
        }
    }

    // MARK: Enums

    enum SetupStatus: CaseIterable {
        case notStarted, accessDenied, loading, failed, success
    }

    enum RunStatus: CaseIterable {
        case stopped, loading, running
    }
}

// MARK: - Privates

private extension CameraManager {

    // MARK: Functions

    func setupCapture() async -> Bool {
        captureSession.sessionPreset = .vga640x480
        captureSession.beginConfiguration()

        guard
            await setupInputs(),
            captureSession.canAddOutput(captureOutput)
        else { return false }

        captureOutput.connection(with: .video)?.isEnabled = true
        captureOutput.alwaysDiscardsLateVideoFrames = true
        captureOutput.connection(with: .video)?.isVideoMirrored = true

        captureSession.addOutput(captureOutput)

        captureSession.commitConfiguration()
        return true
    }

    func setupInputs() async -> Bool {
        async let frontCameraInput: AVCaptureDeviceInput? = await Task.detached {
            guard let camera: AVCaptureDevice = .default(
                .builtInWideAngleCamera,
                for: .video,
                position: .front
            ) else { return nil }

            return try? .init(device: camera)
        }.value

        async let backCameraInput: AVCaptureDeviceInput? = await Task.detached {
            guard let camera: AVCaptureDevice = .default(
                .builtInWideAngleCamera,
                for: .video,
                position: .back
            ) else { return nil }

            return try? .init(device: camera)
        }.value

        (frontCamera, backCamera) = await (frontCameraInput, backCameraInput)

        switch (frontCamera, backCamera) {
        case (.some, .some(let backCamera)):
            currentCamera = .back
            captureSession.addInput(backCamera)
            return true

        case (.some(let frontCamera), .none):
            captureSession.addInput(frontCamera)
            return true

        case (.none, .some(let backCamera)):
            captureSession.addInput(backCamera)
            return true

        case (.none, .none):
            return false
        }
    }
}
