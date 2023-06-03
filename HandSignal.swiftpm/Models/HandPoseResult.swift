//
//  HandPoseResult.swift
//  
//
//  Created by Alperen Örence on 1.04.2023.
//

import Foundation

// MARK: - HandPoseResult

struct HandPoseResult {

    // MARK: Properties

    let character: String
    let confidence: Double
    let output: ASLModelOutput

    // MARK: Initializers

    init?(output prediction: ASLModelOutput) {
        guard let confidence = prediction.labelProbabilities[prediction.label],
              confidence >= 0.9
        else { return nil }

        character = prediction.label.first!.uppercased()
        self.confidence = confidence
        output = prediction
    }
}
