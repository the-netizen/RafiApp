//
//  JournalHistory.swift
//  Rafi
//
//  Created by Manar on 11/12/2025.
///
//  ContentView.swift
//  Record
//
//  Created by Manar on 10/12/2025.
//

import SwiftUI

struct JournalHistory: View {
    @State private var entries: [JournalEntry] = [
        JournalEntry(title: "Morning Thoughts", date: Date(), heartLevel: 1),
        JournalEntry(title: "Evening Reflection", date: Date().addingTimeInterval(-86400), heartLevel: 1),
        JournalEntry(title: "Weekend Plans", date: Date().addingTimeInterval(-172800), heartLevel: 3),
        JournalEntry(title: "Daily Goals", date: Date().addingTimeInterval(-259200), heartLevel: 2)
    ]
    
    var body: some View {
        ZStack {
            Color("bluee")
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                // Header
                headerView
                
                // THIN LINE BETWEEN TITLE BOX AND ENTRY CARDS
                Rectangle()
                    .fill(Color.black.opacity(0.4))
                    .frame(height: 0.5) // عرض الفريم
                    .padding(.horizontal, 4)
                    .padding(.vertical, 5)
                
                Spacer()
                
                // Entry Cards
                VStack(spacing: 16) {
                    ForEach(entries) { entry in
                        EntryCard(entry: entry)
                    }
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                // المايك
                microphoneButton
                
                Spacer()
            }
            .padding(.top, 50)
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                }
                
                Spacer()
                
                Text("المدونة")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
                
            
                Image("Book")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
            
            // Line separator
            Rectangle()
                .fill(Color.black.opacity(0.8))
                .frame(height: 2)
                .padding(.horizontal, 20)
        }
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.black, lineWidth: 1.5)
                )
        )
        .padding(.horizontal, 30)
    }
    
    private var microphoneButton: some View {
        Button(action: {
            // Recording action
        }) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 130, height: 130)
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 1.5)
                    )
                    .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
                
                // Your custom mic image - BIGGER
                Image("Mico")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            }
        }
    }
}

// MARK: - Entry Card Component
struct EntryCard: View {
    let entry: JournalEntry
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(entry.title)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
                
                Text(entry.formattedDate)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Your custom heart images based on level
            Image(entry.heartImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.black, lineWidth: 1.5)
                )
        )
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Model
struct JournalEntry: Identifiable {
    let id = UUID()
    var title: String
    var date: Date
    var heartLevel: Int // 1 = Fullheart, 2 = Midheart, 3 = heart3, 4 = heart4
    
    var heartImageName: String {
        switch heartLevel {
        case 1:
            return "Fullheart"
        case 2:
            return "Midheart"
        case 3:
            return "heart3"
        case 4:
            return "heart4"
        default:
            return "heart4"
        }
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    JournalHistory()
}
