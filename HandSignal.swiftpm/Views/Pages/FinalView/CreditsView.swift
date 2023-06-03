//
//  CreditsView.swift
//  
//
//  Created by Alperen Örence on 17.04.2023.
//

import SwiftUI

// MARK: - CreditsView

extension FinalView {
    struct CreditsView: View {

        // MARK: Properties

        @Environment(\.dismiss) var dismiss

        // MARK: View
        
        var body: some View {
            VStack {
                Text("CreditsView.title")
                    .font(.custom.title.weight(.semibold))

                ScrollView(showsIndicators: false) {
                    Text("CreditsView.text")
                }
            }
            .overlay(alignment: .topTrailing) {
                Button("CreditsView.closeButton.title", action: dismiss.callAsFunction)
            }
            .padding()
        }
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        FinalView.CreditsView()
            .setupPreview()
    }
}
