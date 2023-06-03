//
//  AboutSLView+UI.swift
//  
//
//  Created by Alperen Örence on 27.03.2023.
//

import SwiftUI

// MARK: - AboutSLView UI

extension AboutSLView {

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
        Text("AboutSLView.title")
            .font(.custom.pageTitle)
            .moveEffect(
                animation: defaultAnimation,
                isAnimated: isAnimated
            )
    }

    var contentView: some View {
        HStack {
            QAView(
                systemImage: "hand.wave",
                title: "AboutSLView.q1.title",
                description: "AboutSLView.q1.description"
            )
            .frame(minWidth: 500)
            .moveEffect(
                animation: defaultAnimation.delay(0.25),
                isAnimated: isAnimated
            )

            QAView(
                systemImage: "globe.americas",
                title: "AboutSLView.q2.title",
                description: "AboutSLView.q2.description",
                image: .init("ASL")
            )
            .frame(minWidth: 500)
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
