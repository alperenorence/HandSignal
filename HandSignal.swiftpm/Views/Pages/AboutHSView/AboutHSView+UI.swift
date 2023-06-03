//
//  AboutHSView+UI.swift
//  
//
//  Created by Alperen Örence on 2.04.2023.
//

import SwiftUI

// MARK: - AboutHSView UI

extension AboutHSView {

    var bodyView: some View {
        VStack {
            Spacer()
            titleView
            contentView
            Spacer()
            navigationButtonsView
        }
    }

    var titleView: some View {
        Text("AboutHSView.title")
            .font(.custom.pageTitle)
            .moveEffect(
                animation: defaultAnimation,
                isAnimated: isAnimated
            )
    }

    var contentView: some View {
        HStack {
            QAView(
                title: "AboutHSView.q1.title",
                description: "AboutHSView.q1.description"
            )
            .moveEffect(
                animation: defaultAnimation.delay(0.25),
                isAnimated: isAnimated
            )

            QAView(
                systemImage: "hand.raised.brakesignal",
                title: "AboutHSView.q2.title",
                description: "AboutHSView.q2.description"
            )
            .moveEffect(
                animation: defaultAnimation.delay(0.5),
                isAnimated: isAnimated
            )
        }
    }

    var navigationButtonsView: some View {
        NavigationButtonsView.both()
            .moveEffect(
                animation: defaultAnimation.delay(0.75),
                isAnimated: isAnimated
            )
    }
}
