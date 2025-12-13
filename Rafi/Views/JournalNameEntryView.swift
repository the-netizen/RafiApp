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
    @State private var rating: Int = 3 // 1...5

    var onAdd: (_ title: String, _ rating: Int) -> Void

    var body: some View {
        VStack(spacing: 18) {
            Text("Name your recording")
                .font(.system(size: 22, weight: .semibold))
                .padding(.top, 18)

            TextField("Type something", text: $title)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .padding(.horizontal, 24)

            // ✅ hearts rating (نفس شكل المثال)
            HeartsRatingView(rating: $rating)
                .padding(.top, 6)

            Button {
                onAdd(title, rating)
                dismiss()
            } label: {
                Text("Add")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color("buttonColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 24)
            .padding(.top, 8)

            Button("Cancel") { dismiss() }
                .foregroundColor(.blue)
                .padding(.bottom, 18)
        }
        .presentationDetents([.medium]) // ✅ “نص الشاشة”
        .presentationDragIndicator(.visible)
    }
}

struct HeartsRatingView: View {
    @Binding var rating: Int

    var body: some View {
        HStack(spacing: 16) {
            ForEach(1...5, id: \.self) { i in
                Button {
                    rating = i
                } label: {
                    Image(heartAsset(for: i))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34, height: 34) // ✅ حجم القلوب (مو عريض)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 18)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color.black, lineWidth: 2)
                .background(Color.white.opacity(0.001))
        )
    }

    private func heartAsset(for index: Int) -> String {
        // عدّلي أسماء الأصول حسب اللي عندك:
        // empty: heart3
        // mid: Midheart
        // full: Fullheart
        if index < rating { return "Fullheart" }
        if index == rating { return "Midheart" }   // أو Fullheart إذا تبينها كاملة
        return "heart3"
    }
}
