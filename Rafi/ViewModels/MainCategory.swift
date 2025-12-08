
import Foundation
import SwiftUI

enum MainCategory: String, Identifiable, CaseIterable {
    case home = "في المنزل"
    case outside = "في الخارج"
    case journal = "دوّن"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .home: return "sofa_icon"
        case .outside: return "tree_icon"
        case .journal: return "journal_icon"
        }
    }
}
