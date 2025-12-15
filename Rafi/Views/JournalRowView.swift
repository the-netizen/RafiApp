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
                // ✅ Hearts on the LEFT
                Image(entry.rating >= 4 ? "Fullheart" : "Midheart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
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
}
