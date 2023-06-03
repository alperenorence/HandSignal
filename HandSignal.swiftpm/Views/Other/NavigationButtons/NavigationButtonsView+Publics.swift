//
//  NavigationButtonsView+Publics.swift
//  
//
//  Created by Alperen Örence on 13.04.2023.
//

import SwiftUI

// MARK: - NavigationButtonsView Publics

extension NavigationButtonsView {}

// MARK: - ButtonView

extension NavigationButtonsView {
    struct ButtonView: View {

        // MARK: Properties

        @EnvironmentObject var navigationManager: NavigationManager
        @EnvironmentObject var cameraManager: CameraManager

        var isNext: Bool
        var title: LocalizedStringKey
        var systemImage: String
        var direction: LayoutDirection

        // MARK: View

        var body: some View {
            Button(action: onButtonTapped) {
                Label(title, systemImage: systemImage)
                    .labelStyle(NavigationLabelStyle(imageDirection: direction))
            }
        }

        // MARK: Functions

        func onButtonTapped() {
            guard cameraManager.runStatus != .loading else { return }
            
            Task {
                await cameraManager.stopCapture()

                if isNext {
                    navigationManager.navigateToNext()
                } else {
                    navigationManager.navigateToPrevius()
                }
            }
        }
    }
}
