//
//  CameraView.swift
//  
//
//  Created by Alperen Örence on 27.03.2023.
//

import SwiftUI

// MARK: - CameraView

struct CameraView: View {

    // MARK: Properties

    @EnvironmentObject var handPoseDetector: HandPoseDetector
    @EnvironmentObject var cameraManager: CameraManager

    // MARK: View
    
    var body: some View {
        AVCaptureView()
            .background(.ultraThinMaterial)
            .overlay(cameraBadgeView)
            .overlay(alignment: .bottomTrailing) {
                switchCameraBadgeView
            }
            .task(onAppear)
    }
}

// MARK: - Previews

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
            .setupPreview()
    }
}
