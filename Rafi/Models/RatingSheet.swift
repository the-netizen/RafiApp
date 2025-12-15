//
//  RatingSheet.swift
//  Rafi
//
//  Created by Noor Alhassani on 24/06/1447 AH.
//

internal import SwiftUI

struct RatingSheet: View {
    @Binding var title: String
    @Binding var rating: Int
    let onAdd: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Capsule()
                .fill(Color.gray.opacity(0.35))
                .frame(width: 48, height: 5)
                .padding(.top, 8)

            Text("Name your recording")
                .font(.system(size: 22, weight: .semibold))
                .padding(.top, 8)

            TextField("Type something", text: $title)
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(Color.black.opacity(0.25), lineWidth: 1.2)
                )
                .cornerRadius(22)
                .padding(.horizontal, 20)

            // ✅ قلوب مثل تصميمك (اختاري أسماء الأصول عندك)
            HStack(spacing: 18) {
                heartButton(level: 0, asset: "heart4")   // عدّلي لو عندك قلب فاضي
                heartButton(level: 1, asset: "heart4")
                heartButton(level: 2, asset: "heart3")
                heartButton(level: 3, asset: "Midheart")
                heartButton(level: 4, asset: "Fullheart")
            }
            .padding(.vertical, 6)

            Button(action: onAdd) {
                Text("Add")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color("buttonColor"))
                    .cornerRadius(28)
                    .shadow(color: Color.black.opacity(0.18), radius: 8, x: 0, y: 6)
            }
            .padding(.horizontal, 20)
            .padding(.top, 6)

            Button("Cancel", action: onCancel)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.blue)
                .padding(.bottom, 16)
        }
        .presentationDetents([.medium]) // ✅ يطلع نص الشاشة
        .presentationDragIndicator(.visible)
        .background(Color.white)
    }

    private func heartButton(level: Int, asset: String) -> some View {
        Button {
            rating = level
        } label: {
            Image(asset)
                .resizable()
                .scaledToFit()
                .frame(width: 34, height: 34) // حجم القلب داخل السطر
                .opacity(rating == level ? 1.0 : 0.55)
        }
        .buttonStyle(.plain)
    }
}
