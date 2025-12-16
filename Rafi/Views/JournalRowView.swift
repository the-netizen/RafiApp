//
//  JournalRowView.swift
//  Rafi
//
//  Created by Noor Alhassani on 24/06/1447 AH.
//

internal import SwiftUI

struct JournalRowView: View {
    let entry: JournalEntry
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                // Static heart display showing the rating
                VStack {
                    Image(heartImageForRating(entry.rating))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 26, height: 26)
                }
                .frame(width: 40) // Fixed width to prevent layout jumping
                .padding(.leading, 12)

                VStack(alignment: .leading, spacing: 6) {
                    Text(entry.title)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)

                    Text(DateFormatters.journalRow.string(from: entry.date))
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 16)

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black.opacity(0.08), lineWidth: 1)
            )
            .padding(.horizontal, 18)
        }
        .buttonStyle(.plain)
    }
    
    private func heartImageForRating(_ rating: Int) -> String {
        switch rating {
        case 1: return "heart100"  // Most filled
        case 2: return "heart75"   
        case 3: return "heart50"   
        case 4: return "heart25"   
        case 5: return "heart0"    // Empty
        default: return "heart0"
        }
    }
}
