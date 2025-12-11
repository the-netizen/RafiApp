import Foundation
internal import SwiftUI
import Combine

class UpdatedCardViewModel: ObservableObject {

    let category: MainCategory
    @Published var challenges: [ChallengeCard] = []

    init(category: MainCategory) {
        self.category = category
        loadChallenges()
    }

    private func loadChallenges() {
        switch category {
        case .home:
            challenges = HomeChallenges
        case .outside:
            challenges = OutsideChallenges
        case .journal:
            challenges = JournalChallenges
        }
    }
}
