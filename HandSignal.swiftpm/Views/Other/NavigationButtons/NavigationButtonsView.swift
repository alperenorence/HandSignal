//
//  NavigationButtonsView.swift
//  
//
//  Created by Alperen Örence on 26.03.2023.
//

import SwiftUI

// MARK: - NavigationButtonsView

enum NavigationButtonsView: View {

    // MARK: Cases

    case next(_ title: LocalizedStringKey = "NavigationButtonsView.next")
    case previus(_ title: LocalizedStringKey = "NavigationButtonsView.previus")
    case both(nextTitle: LocalizedStringKey = "NavigationButtonsView.next",
              previusTitle: LocalizedStringKey = "NavigationButtonsView.previus")

    // MARK: View

    var body: some View {
        bodyView
            .tint(.white)
    }

    @ViewBuilder var bodyView: some View {
        switch self {
        case let .next(title):
            nextButton(title: title)

        case let .previus(title):
            previusButton(title: title)

        case let .both(nextTitle, previusTitle):
            HStack {
                Spacer()
                previusButton(title: previusTitle)
                Spacer()
                nextButton(title: nextTitle)
                Spacer()
            }
        }
    }

    func nextButton(title: LocalizedStringKey) -> some View {
        ButtonView(isNext: true,
                   title: title,
                   systemImage: "chevron.right",
                   direction: .rightToLeft)
    }

    func previusButton(title: LocalizedStringKey) -> some View {
        ButtonView(isNext: false,
                   title: title,
                   systemImage: "chevron.left",
                   direction: .leftToRight)
    }
}

// MARK: - Previews

struct NavigationButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationButtonsView.both()
            .setupPreview()
    }
}
