//
//  NavigationManager.swift
//  
//
//  Created by Alperen Örence on 26.03.2023.
//

import SwiftUI

// MARK: - NavigationManager

@MainActor class NavigationManager: ObservableObject {

    // MARK: Properties

    @Published var pageIndex: Int = 0
}

// MARK: - Publics

extension NavigationManager {

    // MARK: Properties

    var page: Page {
        Page.allCases[pageIndex]
    }

    // MARK: Functions

    func navigateToNext() {
        if Page.allCases.indices.contains(pageIndex + 1) {
            pageIndex += 1
        }
    }

    func navigateToPrevius() {
        if Page.allCases.indices.contains(pageIndex - 1) {
            pageIndex -= 1
        }
    }
}
