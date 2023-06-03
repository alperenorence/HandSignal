//
//  AnimatedGradient.swift
//
//
//  Created by Alperen Örence on 22.03.2023.
//

import SwiftUI

// MARK: - AnimatedGradient

struct AnimatedGradient: View {

    // MARK: Properties

    @State var secondGradientOpacity: CGFloat = 0.1

    var firstGradient: [Color]
    var secondGradient: [Color]

    // MARK: View

    var body: some View {
        ZStack {
            LinearGradient(
                colors: firstGradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            LinearGradient(
                colors: secondGradient,
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            .opacity(secondGradientOpacity)
        }
        .onAppear(perform: colorAnimation)
    }
}

// MARK: - Privates

private extension AnimatedGradient {

    // MARK: Functions

    @Sendable func colorAnimation() {
        let animation: Animation = .linear(duration: 5.0)
            .delay(1.0)
            .repeatForever(autoreverses: true)

        withAnimation(animation) {
            secondGradientOpacity = 0.1
            secondGradientOpacity = 0.5
            secondGradientOpacity = 0.5
            secondGradientOpacity = 0.9
        }
    }
}

// MARK: - Previews

struct AnimatedGradient_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedGradient(
            firstGradient: [.blue, .red],
            secondGradient: [.purple, .green]
        )
    }
}
