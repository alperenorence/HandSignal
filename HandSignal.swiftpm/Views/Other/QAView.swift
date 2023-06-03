//
//  QAView.swift
//  
//
//  Created by Alperen Örence on 27.03.2023.
//

import SwiftUI

// MARK: - QAView

struct QAView: View {

    // MARK: Properties

    var systemImage: String? = nil
    var title: LocalizedStringKey
    var description: LocalizedStringKey
    var image: Image? = nil

    // MARK: View

    var body: some View {
        VStack(spacing: 16) {
            titleLabelView
            descriptionView
            imageView
        }
        .padding()
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .padding()
    }
}

// MARK: - UI

extension QAView {
    
    var titleLabelView: some View {
        HStack {
            if let systemImage {
                Image(systemName: systemImage)
            }

            Text(title)
        }
        .font(.custom.title)
        .bold()
    }

    var descriptionView: some View {
        Text(description)
            .font(.custom.body)
            .minimumScaleFactor(0.5)
    }

    var imageView: some View {
        image?
            .renderingMode(.template)
            .foregroundColor(.white)
    }
}

// MARK: - Previews

struct QAView_Previews: PreviewProvider {
    static var previews: some View {
        QAView(
            systemImage: "globe",
            title: "Question",
            description: "Answer"
        )
    }
}
