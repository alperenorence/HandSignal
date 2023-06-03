//
//  FinalView+UI.swift
//  
//
//  Created by Alperen Örence on 15.04.2023.
//

import SwiftUI

// MARK: - FinalView UI

extension FinalView {

    var bodyView: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                logoView(size: geo.size)
                Spacer()
                contentView
                Spacer()
                navigationButtons
                Spacer()
            }
        }
    }

    func logoView(size: CGSize) -> some View {
        VStack(spacing: 20) {
            Text("FinalView.logo.description")
                .font(.custom.largeTitle2Rounded)
                .moveEffect(
                    animation: defaultAnimation,
                    isAnimated: isAnimated
                )

            Image("HSLogoWithoutDescription")
                .resizable()
                .scaledToFit()
                .frame(width: size.width * 0.4)
                .moveEffect(
                    animation: defaultAnimation.delay(0.25),
                    isAnimated: isAnimated
                )
        }
    }

    var contentView: some View {
        HStack {
            QAView(
                systemImage: "person.fill.questionmark",
                title: "FinalView.content.q1.title",
                description: "FinalView.content.q1.description"
            )
            .frame(maxWidth: 500)
            .moveEffect(
                animation: defaultAnimation.delay(0.75),
                isAnimated: isAnimated
            )

            QAView(
                systemImage: "hammer.fill",
                title: "FinalView.content.q2.title",
                description: "FinalView.content.q2.description"
            )
            .frame(maxWidth: 500)
            .moveEffect(
                animation: defaultAnimation.delay(1),
                isAnimated: isAnimated
            )
        }
    }

    var navigationButtons: some View {
        HStack {
            Spacer()
            NavigationButtonsView.previus()
            Spacer()
            creditsButtonView
            Spacer()

            Button {
                navigationManager.pageIndex = 0
            } label: {
                Label {
                    Text("FinalView.navigationButton.start")
                } icon: {
                    EmptyView()
                }
                .labelStyle(NavigationLabelStyle())
            }
            .tint(.white)

            Spacer()
        }
        .moveEffect(
            animation: defaultAnimation.delay(1.25),
            isAnimated: isAnimated
        )
    }

    var creditsButtonView: some View {
        Button {
            isCreditsShowing = true
        } label: {
            Text("FinalView.creditsButton.title")
                .font(.custom.body)
                .padding(10)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
        }
        .tint(.white)
    }
}
