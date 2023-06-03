//
//  View+Extension.swift
//  
//
//  Created by Alperen Örence on 23.03.2023.
//

import SwiftUI

// MARK: - View Extension

extension View {

    func animate(
        isAnimated: Binding<Bool>,
        wait duration: Duration
    ) -> some View {
        self
            .onAppear {
                Task { @MainActor in
                    try? await Task.sleep(for: duration)
                    isAnimated.wrappedValue = true
                }
            }
            .onDisappear {
                isAnimated.wrappedValue = false
            }
    }

    func moveEffect(
        animation: Animation = .default,
        isAnimated: Bool,
        x: CGFloat = 0,
        y: CGFloat = 15
    ) -> some View {
        self
            .offset(x: isAnimated ? 0 : x, y: isAnimated ? 0 : y)
            .opacity(isAnimated ? 1 : 0)
            .animation(animation, value: isAnimated)
    }

    @MainActor func setupPreview() -> some View {
        self
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.landscapeRight)
            .previewDevice("iPad Pro (11-inch) (4th generation)")
            .environmentObject(NavigationManager())
            .environmentObject(CameraManager())
            .environmentObject(HandPoseDetector())
    }
}
