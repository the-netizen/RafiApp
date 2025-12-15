import Foundation

enum DateFormatters {
    static let journalRow: DateFormatter = {
        let df = DateFormatter()
        // Example: "Dec 15, 2025 · 3:42 PM"
        df.locale = Locale.current
        df.dateFormat = "MMM d, yyyy · h:mm a"
        return df
    }()
}
