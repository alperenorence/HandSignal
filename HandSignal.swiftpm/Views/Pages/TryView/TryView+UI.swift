//
//  TryView+UI.swift
//  
//
//  Created by Alperen Örence on 15.04.2023.
//

import SwiftUI

// MARK: - TryView UI

extension TryView {

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
        Text("TryView.title")
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
            .both(nextTitle: isCompleted ? "NavigationButtonsView.next" : "NavigationButtonsView.skip")
            .moveEffect(
                animation: defaultAnimation.delay(1),
                isAnimated: isAnimated
            )
    }

    var infoView: some View {
        VStack {
            topInfoView
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .animation(.easeInOut, value: isCompleted)
                .moveEffect(
                    animation: defaultAnimation.delay(0.25),
                    isAnimated: isAnimated
                )

            bottomInfoView
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .animation(.easeInOut, value: wordValue.currentLetter)
                .animation(.easeInOut, value: selectedLetter)
                .moveEffect(
                    animation: defaultAnimation.delay(0.5),
                    isAnimated: isAnimated
                )
        }
    }

    @ViewBuilder var topInfoView: some View {
        if isCompleted {
            completedView
        } else {
            Text("TryView.description")
                .frame(maxWidth: .infinity)
                .font(.custom.body)
        }
    }

    var bottomInfoView: some View {
        VStack {
            if let selectedLetter {
                letterView(for: selectedLetter)
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [.init(), .init(), .init()]) {
                        ForEach(letters, id: \.self) { letter in
                            Button(letter) {
                                selectedLetter = letter
                            }
                            .font(.custom.letter)
                            .tint(.white)
                            .matchedGeometryEffect(id: letter, in: namespace)
                            .padding()
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .animation(.easeInOut, value: selectedLetter)
    }

    var completedView: some View {
        VStack {
            Text("TryView.completed.title")
                .font(.custom.title.weight(.semibold))

            Text("TryView.completed.description")
                .font(.custom.body)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
    }

    func letterView(for letter: String) -> some View {
        VStack {
            Text(letter)
                .font(.custom.letter)
                .matchedGeometryEffect(id: letter, in: namespace)
                .frame(maxWidth: .infinity)
                .background(alignment: .topLeading) {
                    Button {
                        selectedLetter = nil
                    } label: {
                        Label("TryView.buttons.back", systemImage: "chevron.left")
                    }
                    .tint(.white)
                }

            Spacer()

            letterImageView(letter.lowercased())
                .opacity(selectedLetter == letter ? 1 : 0)

            Spacer()
        }
    }

    func letterImageView(_ name: String) -> some View {
        Image(name)
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.white)
            .scaledToFit()
    }
}
