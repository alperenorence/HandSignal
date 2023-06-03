//
//  FinalView.swift
//  
//
//  Created by Alperen Örence on 15.04.2023.
//

import SwiftUI

// MARK: - FinalView

struct FinalView: View {

    // MARK: Properties

    @EnvironmentObject var navigationManager: NavigationManager

    @State var isAnimated: Bool = false
    @State var isCreditsShowing: Bool = false

    let defaultAnimation: Animation = .easeIn.speed(0.5)

    // MARK: View

    var body: some View {
        bodyView
            .animate(isAnimated: $isAnimated, wait: .seconds(0.25))
            .sheet(isPresented: $isCreditsShowing) {
                CreditsView()
            }
    }
}

// MARK: - Previews

struct FinalView_Previews: PreviewProvider {
    static var previews: some View {
        FinalView()
            .setupPreview()
    }
}
