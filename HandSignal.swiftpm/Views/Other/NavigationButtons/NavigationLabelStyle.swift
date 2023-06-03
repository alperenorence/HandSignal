//
//  NavigationLabelStyle.swift
//  
//
//  Created by Alperen Örence on 13.04.2023.
//

import SwiftUI

// MARK: - NavigationLabelStyle

struct NavigationLabelStyle: LabelStyle {

    // MARK: Properties

    var imageDirection: LayoutDirection = .leftToRight

    // MARK: View

    func makeBody(configuration: Configuration) -> some View {
        contentView(configuration: configuration)
            .font(.custom.title2)
            .padding()
            .overlay(borderView)
    }

    func contentView(configuration: Configuration) -> some View {
        HStack {
            switch imageDirection {
            case .leftToRight:
                configuration.icon
                configuration.title

            case .rightToLeft:
                configuration.title
                configuration.icon

            @unknown default:
                configuration.icon
                configuration.title
            }
        }
    }

    var borderView: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(.white, lineWidth: 3)
    }
}

// MARK: - Previews

struct NavigationLabelStyle_Previews: PreviewProvider {
    static var previews: some View {
        Label("Next", systemImage: "chevron.right")
            .labelStyle(NavigationLabelStyle(imageDirection: .rightToLeft))
            .setupPreview()
    }
}
