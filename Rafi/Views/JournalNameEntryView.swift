//
//  JournalNameEntryView.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//

internal import SwiftUI

struct JournalNameEntryView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var heartLevel: Int = 3   // default middle heart (3/5)

    /// Called when user taps Add
    let onAdd: (String, Int) -> Void

    /// Called when user taps Cancel
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: 24) {

            // drag indicator
            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 60, height: 5)
                .padding(.top, 8)

            Text("Name your recording")
                .font(.system(size: 20, weight: .semibold))

            // ---------- TEXT FIELD ----------
            TextField("Type something", text: $title)
                .padding(.horizontal, 18)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.black.opacity(0.25), lineWidth: 1.2)
                )
                .padding(.horizontal, 32)

            // ---------- HEART RATING ----------
            HStack(spacing: 16) {
                ForEach(1...5, id: \.self) { level in
                    Button {
                        heartLevel = level
                    } label: {
                        Image(imageName(for: level))
                            .resizable()
                            .interpolation(.none)       // keep pixel look
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.black.opacity(0.25), lineWidth: 1.2)
            )
            .padding(.horizontal, 32)

            // If you want to show duration later, put it here:
            // Text("13:00")
            //    .font(.system(size: 22, weight: .medium))

            // ---------- ADD BUTTON ----------
            Button {
                onAdd(title.isEmpty ? "Untitled recording" : title, heartLevel)
                dismiss()
            } label: {
                Text("Add")
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color("buttonColor")) // use your orange asset
                    )
                    .padding(.horizontal, 80)
                    .shadow(color: .black.opacity(0.15),
                            radius: 4, x: 0, y: 3)
            }

            Button("Cancel", role: .cancel) {
                onCancel()
                dismiss()
            }
            .font(.system(size: 16))
            .padding(.top, 2)

            Spacer()
        }
        .padding(.bottom, 24)
    }

    // MARK: - Hearts mapping

    /// Decide which image to show for each heart position
    private func imageName(for level: Int) -> String {
        // You can adjust this mapping to your taste using:
        // "Fullheart", "Midheart", "heart3", "heart4"
        if level <= heartLevel {
            // selected hearts
            switch heartLevel {
            case 1, 2:
                return "heart3"     // softer fill when low rating
            case 3:
                return "Midheart"   // middle pixel heart
            default:
                return "Fullheart"  // strong red when high rating
            }
        } else {
            // unselected (outline) heart
            return "heart4"
        }
    }
}
