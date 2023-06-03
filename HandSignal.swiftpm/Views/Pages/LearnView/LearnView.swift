//
//  LearnView.swift
//  
//
//  Created by Alperen Örence on 11.04.2023.
//

import SwiftUI

// MARK: - LearnView

struct LearnView: View {

    // MARK: Properties

    @State var isAnimated: Bool = false
    @State var wordValue: HandDetectorView.WordValue = .init(targetWords: ["ABC", "HELLO"])

    let defaultAnimation: Animation = .easeIn.speed(0.5)

    // MARK: View

    var body: some View {
        bodyView
            .animate(isAnimated: $isAnimated, wait: .seconds(0.25))
    }
}

// MARK: - Previews

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
            .setupPreview()
    }
}
