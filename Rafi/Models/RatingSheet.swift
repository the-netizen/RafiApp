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

            // Heart Rating with sliding orb
            HeartRatingView(rating: $rating, size: 34)
                .padding(.vertical, 16)

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
}
