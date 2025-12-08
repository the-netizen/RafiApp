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
    
    // Hashable conformance for NavigationLink (no idea what it does but dont touch this)
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ChallengeCard, rhs: ChallengeCard) -> Bool {
        lhs.id == rhs.id
    }
}

final class CardViewViewModel: ObservableObject {
    @Published var currentIndex: Int = 0
    @Published var cards: [ChallengeCard] = []
    let category: MainCategory

    init(category: MainCategory) {
        self.category = category
        loadCardsForCategory()
    }

    
//    @Published var cards: [ChallengeCard] = [
//        .init(title: "عنوان", description: "نبذة عن التحدي", difficultyImageName: "skull_level1"),
//        .init(title: "عنوان ٢", description: "نبذة عن التحدي", difficultyImageName: "skull_level2"),
//        .init(title: "عنوان ٣", description: "نبذة عن التحدي", difficultyImageName: "skull_level3")
//    ]


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
    
    func loadCardsForCategory() {
            switch category {
            case .home:
                self.cards = HomeChallenges
            case .outside:
                self.cards = OutsideChallenges
            case .journal:
                self.cards = JournalChallenges
            }
        }
}
