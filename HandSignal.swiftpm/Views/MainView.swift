//
//  MainView.swift
//  HandSignal
//
//  Created by Alperen Örence on 22.03.2023.
//

import SwiftUI

// MARK: - MainView

struct MainView: View {

    // MARK: Properties

    @StateObject var navigationManager: NavigationManager = .init()
    @StateObject var cameraManager: CameraManager = .init()
    @StateObject var handPoseDetector: HandPoseDetector = .init()

    // MARK: View

    var body: some View {
        ZStack {
            AnimatedGradient(
                firstGradient: [.black, .blue.opacity(0.8)],
                secondGradient: [.black, .cyan.opacity(0.8)]
            )
            .ignoresSafeArea()

            contentView
                .padding()
                .padding()
        }
        .animation(.linear, value: navigationManager.page)
        .preferredColorScheme(.dark)
        .environmentObject(navigationManager)
        .environmentObject(cameraManager)
        .environmentObject(handPoseDetector)
    }

    var contentView: some View {
        GeometryReader { geo in
            if geo.size.width > 1000 {
                navigationManager.page
            } else {
                screenAlertView
            }
        }
    }

    var screenAlertView: some View {
        Text("MainView.screenSizeAlert")
            .font(.custom.body)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Previews

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.landscapeRight)
            .previewDevice("iPad Pro (11-inch) (4th generation)")
    }
}
