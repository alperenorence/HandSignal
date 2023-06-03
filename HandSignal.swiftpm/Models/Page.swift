//
//  Page.swift
//
//
//  Created by Alperen Örence on 23.03.2023.
//

import SwiftUI

// MARK: - Page

enum Page: View, CaseIterable {
    
    case intro, aboutSL, aboutHS, learn, `try`, final

    var body: some View {
        switch self {
        case .intro:
            IntroView()

        case .aboutSL:
            AboutSLView()

        case .aboutHS:
            AboutHSView()

        case .learn:
            LearnView()

        case .try:
            TryView()

        case .final:
            FinalView()
        }
    }
}
