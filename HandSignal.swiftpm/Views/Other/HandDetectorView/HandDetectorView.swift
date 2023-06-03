//
//  HandDetectorView.swift
//  
//
//  Created by Alperen Örence on 1.04.2023.
//

import SwiftUI

// MARK: - HandDetectorView

struct HandDetectorView: View {

    // MARK: Properties

    @EnvironmentObject private var handPoseDetector: HandPoseDetector
    @StateObject var viewModel: ViewModel

    // MARK: Initializers

    init(wordValue: WordValue = .init()) {
        let viewModel: ViewModel = .init(
            wordValue: wordValue,
            valueBinding: nil
        )
        
        _viewModel = .init(wrappedValue: viewModel)
    }

    init(wordValue: Binding<WordValue>) {
        let viewModel: ViewModel = .init(
            wordValue: wordValue.wrappedValue,
            valueBinding: wordValue
        )

        _viewModel = .init(wrappedValue: viewModel)
    }

    // MARK: View

    var body: some View {
        CameraView()
            .overlay(overlayView, alignment: .top)
            .cornerRadius(10)
            .onAppear {
                viewModel.onAppear(handPoseDetector: handPoseDetector)
            }
    }
}

// MARK: - Previews

struct HandDetectorView_Previews: PreviewProvider {
    static var previews: some View {
        HandDetectorView(wordValue: .init(targetWords: ["ABC"]))
            .setupPreview()
    }
}
