//
//  LearnView+UI.swift
//  
//
//  Created by Alperen Örence on 11.04.2023.
//

import SwiftUI

// MARK: - LearnView UI

extension LearnView {

    var bodyView: some View {
        VStack {
            Spacer()
            titleView
            Spacer()
            contentView
            Spacer()
            navigationButtonsView
        }
    }

    var titleView: some View {
        Text("LearnView.title")
            .font(.custom.pageTitle)
            .moveEffect(
                animation: defaultAnimation,
                isAnimated: isAnimated
            )
    }

    var contentView: some View {
        GeometryReader { geo in
            HStack {
                infoView
                    .frame(width: geo.size.width / 3)

                HandDetectorView(wordValue: $wordValue)
                    .moveEffect(
                        animation: defaultAnimation.delay(0.75),
                        isAnimated: isAnimated
                    )
            }
        }
        .padding()
    }

    var navigationButtonsView: some View {
        NavigationButtonsView
            .both(nextTitle: wordValue.isCompleted ? "NavigationButtonsView.next" : "NavigationButtonsView.skip")
            .moveEffect(
                animation: defaultAnimation.delay(1),
                isAnimated: isAnimated
            )
    }

    var infoView: some View {
        VStack {
            if !wordValue.isCompleted {
                topInfoView
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .transition(.scale(scale: 0, anchor: .top))
                    .moveEffect(
                        animation: defaultAnimation.delay(0.25),
                        isAnimated: isAnimated
                    )
            }

            bottomInfoView
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .transition(.opacity)
                .animation(.easeInOut, value: wordValue.currentLetter)
                .moveEffect(
                    animation: defaultAnimation.delay(0.5),
                    isAnimated: isAnimated
                )
        }
        .animation(.easeInOut, value: wordValue.isCompleted)
    }

    var topInfoView: some View {
        Text("LearnView.description")
            .frame(maxWidth: .infinity)
            .font(.custom.body)
    }

    @ViewBuilder var bottomInfoView: some View {
        if wordValue.isCompleted {
            completedView
        } else {
            imageView
        }
    }

    var imageView: some View {
        VStack {
            Text(wordValue.currentLetter ?? "")
                .font(.custom.letter)

            Spacer()

            if let letter = wordValue.currentLetter?.lowercased() {
                letterImageView(letter)
            }

            Spacer()
        }
        .opacity(wordValue.currentLetter == nil ? 0 : 1)
        .frame(maxWidth: .infinity)
    }

    var completedView: some View {
        VStack {
            Text("LearnView.completed.title")
                .font(.custom.title.weight(.semibold))

            Text("LearnView.completed.description")
                .font(.custom.body)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    func letterImageView(_ name: String) -> some View {
        Image(name)
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.white)
            .scaledToFit()
    }
}
