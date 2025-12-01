//
//  CardViewViewModel.swift
//  Rafi
//
//  Created by Huda Chishtee on 01/12/2025.
//

import SwiftUI
import Combine

struct ChallengeCard: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let difficultyImageName: String
}

final class CardViewViewModel: ObservableObject {
    @Published var cards: [ChallengeCard] = [
        .init(title: "عنوان", description: "نبذة عن التحدي", difficultyImageName: "skull_level1"),
        .init(title: "عنوان ٢", description: "نبذة عن التحدي", difficultyImageName: "skull_level2"),
        .init(title: "عنوان ٣", description: "نبذة عن التحدي", difficultyImageName: "skull_level3")
    ]

    @Published var currentIndex: Int = 0

    var canGoNext: Bool { currentIndex < cards.count - 1 }
    var canGoPrev: Bool { currentIndex > 0 }

    func goNext() {
        guard canGoNext else { return }
        currentIndex += 1
    }

    func goPrev() {
        guard canGoPrev else { return }
        currentIndex -= 1
    }

    var currentCard: ChallengeCard? {
        guard cards.indices.contains(currentIndex) else { return nil }
        return cards[currentIndex]
    }
}
