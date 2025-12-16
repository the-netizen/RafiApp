//
//  JournalNameEntryView.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//
internal import SwiftUI

struct JournalNameEntrySheet: View {
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var rating: Int = 1 // Changed from 3 to 1 to start with heart100

    let audioFileName: String
    let onAdd: (String, Int, String) -> Void

    var body: some View {
        VStack(spacing: 18) {
            Capsule()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 50, height: 6)
                .padding(.top, 10)

            Text("Name your recording")
                .font(.system(size: 24, weight: .bold))

            TextField("Type something", text: $title)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
                .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.3), lineWidth: 1))

            // Heart Rating with sliding orb
            HeartRatingView(rating: $rating, size: 50)
                .padding(.vertical, 16)

            Button {
                let finalTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
                onAdd(finalTitle.isEmpty ? "New Recording" : finalTitle, rating, audioFileName)
                dismiss()
            } label: {
                Text("Add")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color("buttonColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .shadow(radius: 6)
            }
            .padding(.top, 10)

            Button("Cancel") { dismiss() }
                .foregroundColor(.blue)
                .padding(.top, 6)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 20)
        .presentationDetents([.medium])
    }
}
