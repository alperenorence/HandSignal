//
//  CameraView+Publics.swift
//  
//
//  Created by Alperen Örence on 16.04.2023.
//

import Foundation

// MARK: - CameraView Publics

extension CameraView {

    // MARK: Properties

    var status: Status {
        .init(cameraSetupStatus: cameraManager.setupStatus,
              handPoseStatus: handPoseDetector.setupStatus,
              cameraStatus: cameraManager.runStatus)
    }

    var isBadgeHidden: Bool {
        status == .stopped || status == .running || status == .notStarted
    }

    // MARK: Functions

    @Sendable @MainActor func onAppear() async {
        await cameraManager.setupCamera()
        guard cameraManager.setupStatus == .success else { return }

        await handPoseDetector.setup()
        guard handPoseDetector.setupStatus == .success else { return }

        await cameraManager.startCapture()
    }

    // MARK: Enums

    enum Status: CaseIterable {

        // MARK: Cases

        case accessDenied, loading, failed, running, stopped, notStarted

        // MARK: Initializers

        init(cameraSetupStatus: CameraManager.SetupStatus,
             handPoseStatus: HandPoseDetector.SetupStatus,
             cameraStatus: CameraManager.RunStatus) {
            switch (cameraSetupStatus, handPoseStatus, cameraStatus) {
            case (.accessDenied, _, _):
                self = .accessDenied

            case (.failed, _, _), (_, .failed, _):
                self = .failed

            case (.loading, _, _), (_, .loading, _), (_, _, .loading):
                self = .loading

            case (.success, .success, .stopped):
                self = .stopped

            case (.success, .success, .running):
                self = .running

            case (.notStarted, _, _), (_, .notStarted, _):
                self = .notStarted
            }
        }
    }
}
