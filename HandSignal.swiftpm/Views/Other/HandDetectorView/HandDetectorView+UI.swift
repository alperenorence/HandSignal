//
//  HandDetectorView+UI.swift
//  
//
//  Created by Alperen Örence on 1.04.2023.
//

import SwiftUI

// MARK: - HandDetectorView UI

extension HandDetectorView {

    var overlayView: some View {
        HStack {
            Spacer()

            ZStack {
                charactersView
                    .opacity(viewModel.isCompleted ? 0 : 1)

                checkmarkView
                    .opacity(viewModel.isCompleted ? 1 : 0)
            }

            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .animation(.easeInOut, value: viewModel.isCompleted)
        .animation(.easeInOut, value: viewModel.wordValue.currentWord ?? "")
        .animation(.easeInOut, value: viewModel.wordValue.collectedLetters)
    }

    @ViewBuilder var charactersView: some View {
        if let letters = viewModel.letters {
            wordView(letters: letters)
        }

        if let letters = viewModel.wordValue.collectedLetters {
            collectedView(letters: letters.joined(separator: " "))
        }
    }

    var checkmarkView: some View {
        Image(systemName: "checkmark.circle.fill")
            .symbolRenderingMode(.hierarchical)
            .foregroundColor(.green)
            .font(.custom.largeTitle2)
    }

    func wordView(letters: ViewModel.CollectedLetters) -> some View {
        HStack {
            ForEach(Array(letters.enumerated()), id: \.offset) { (_, character) in
                Text(verbatim: character.letter)
                    .font(.custom.letter)
                    .opacity(character.isCompleted ? 1 : 0.5)
            }
        }
    }

    func collectedView(letters: String) -> some View {
        HStack {
            controlButtons
                .disabled(true)
                .hidden()

            Spacer()

            Text(verbatim: letters)
                .font(.custom.letter)
                .frame(maxWidth: .infinity)

            controlButtons
        }
    }

    var controlButtons: some View {
        HStack {
            Button {
                viewModel.wordValue.collectedLetters?.removeLast()
            } label: {
                Image(systemName: "delete.left.fill")
            }
            .font(.custom.body)
            .padding()

            Button {
                guard let word = viewModel.wordValue.collectedLetters?
                    .joined()
                    .capitalized
                else { return }

                UIPasteboard.general.string = word
            } label: {
                Image(systemName: "doc.on.doc.fill")
            }
            .font(.custom.body)
            .padding()
        }
    }
}
