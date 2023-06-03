//
//  IntroView+UI.swift
//  
//
//  Created by Alperen Örence on 27.03.2023.
//

import SwiftUI

// MARK: - IntroView UI

extension IntroView {

    var bodyView: some View {
        GeometryReader { geo in
            VStack {
                Spacer()

                logoView(size: geo.size)

                if isAnimated {
                    Spacer()
                    descriptionView
                    Spacer()
                    nextButtonView
                }

                Spacer()
            }
        }
    }

    func logoView(size: CGSize) -> some View {
        HStack {
            Spacer()

            Image("HSLogoWithoutDescription")
                .resizable()
                .scaledToFit()
                .overlay {
                    Image("HSLogoDescription")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimated ? 1 : 0)
                }
                .frame(width: size.width * (isAnimated ? 0.5 : 0.875))

            Spacer()
        }
    }

    var descriptionView: some View {
        Text("IntroView.description")
            .font(.custom.body)
            .multilineTextAlignment(.center)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .frame(maxWidth: 550)
            .padding(.horizontal, isAnimated ? 30 : 0)
            .animation(.easeOut, value: isAnimated)
    }

    var nextButtonView: some View {
        NavigationButtonsView
            .next("IntroView.navigationButton.next")
    }
}
