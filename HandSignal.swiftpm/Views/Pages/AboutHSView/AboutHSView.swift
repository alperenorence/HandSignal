//
//  AboutHSView.swift
//  
//
//  Created by Alperen Örence on 30.03.2023.
//

import SwiftUI

// MARK: - AboutHSView

struct AboutHSView: View {

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

struct AboutHSView_Previews: PreviewProvider {
    static var previews: some View {
        AboutHSView()
            .setupPreview()
    }
}
