
import Foundation
internal import SwiftUI
import Combine

class MainViewViewModel: ObservableObject {
    
    @Published var userName: String = ""
    @Published var avatarName: String = "avatar1"
    @Published var navigationPath = NavigationPath()
    
//    @Published var challenges: [ChallengeCard] = []
    
//    let category: MainCategory
    let categories: [MainCategory] = [.home, .outside, .journal]
    
    func configure(name: String, avatar: String) {
        self.userName = name
        self.avatarName = avatar
    }
    
    func navigateToCategory(_ category: MainCategory) {
        print("Navigating to category: \(category.rawValue)")
        navigationPath.append(category)
    }

}
