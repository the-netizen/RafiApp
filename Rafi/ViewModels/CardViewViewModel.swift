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
    let difficultyImageName: String
    let titleKey: String
    let descriptionKey: String
    let conditionsKey: String
    
    // fetch Localized data
    var title: String {
        NSLocalizedString(titleKey, comment: "")
    }
    var description: String {
        NSLocalizedString(descriptionKey, comment: "")
    }
    var conditions: String {
        NSLocalizedString(conditionsKey, comment: "")
    }
    
    
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

    var canGoNext: Bool { currentIndex < cards.count - 1 }
    var canGoPrev: Bool { currentIndex > 0 }

    func goNext() {
        guard !cards.isEmpty else { return }
        currentIndex = (currentIndex + 1) % cards.count
    }

    func goPrev() {
        guard !cards.isEmpty else { return }
        currentIndex = (currentIndex - 1 + cards.count) % cards.count
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
