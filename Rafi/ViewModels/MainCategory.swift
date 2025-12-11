
import Foundation
import SwiftUI

enum MainCategory: String, Identifiable, CaseIterable {
    case home
    case outside
    case journal

    var id: String { rawValue }
    
    var title: String {
        switch self{
        case .home: return NSLocalizedString("home", comment: "")
        case .outside: return NSLocalizedString("outside", comment: "")
        case .journal: return NSLocalizedString("journal", comment: "")
        }
    }

    var iconName: String {
        switch self {
        case .home: return "sofa_icon"
        case .outside: return "tree_icon"
        case .journal: return "journal_icon"
        }
    }
    
    
}
