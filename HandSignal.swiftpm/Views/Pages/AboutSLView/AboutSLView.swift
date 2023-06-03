//
//  AboutSLView.swift
//  
//
//  Created by Alperen Örence on 25.03.2023.
//

import SwiftUI

// MARK: - AboutSLView

struct AboutSLView: View {

    // MARK: Properties

    @State var isAnimated: Bool = false

    let defaultAnimation: Animation = .easeIn.speed(0.5)

    // MARK: View

    var body: some View {
        bodyView
            .animate(isAnimated: $isAnimated, wait: .seconds(0.25))
    }
}

// MARK: - Previews

struct AboutSLView_Previews: PreviewProvider {
    static var previews: some View {
        AboutSLView()
            .setupPreview()
    }
}
