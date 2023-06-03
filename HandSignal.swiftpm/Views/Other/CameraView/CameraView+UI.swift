//
//  CameraView+UI.swift
//  
//
//  Created by Alperen Örence on 2.04.2023.
//

import SwiftUI

// MARK: - CameraView UI

extension CameraView {

    var cameraBadgeView: some View {
        HStack(spacing: 16) {
            switch status {
            case .accessDenied:
                Label("CameraView.badge.accessDenied", systemImage: "exclamationmark.triangle")

            case .failed:
                Label("CameraView.badge.failed", systemImage: "exclamationmark.triangle")

            case .loading:
                Label("CameraView.badge.loading", systemImage: "camera")

            case .stopped, .running, .notStarted:
                EmptyView()
            }
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(10)
        .opacity(isBadgeHidden ? 0 : 1)
        .animation(.linear(duration: 0.1), value: status)
    }

    var switchCameraBadgeView: some View {
        Button {
            cameraManager.switchCamera()
        } label: {
            Image(systemName: "arrow.triangle.2.circlepath")
        }
        .disabled(cameraManager.currentCamera == nil)
        .padding()
        .background(.regularMaterial)
        .padding([.bottom, .trailing], 10)
        .cornerRadius(10)
        .padding([.bottom, .trailing], -10)
        .clipped()
        .opacity(cameraManager.currentCamera == nil ? 0 : 1)
    }
}
