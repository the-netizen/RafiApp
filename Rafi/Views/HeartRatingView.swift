//
//  HeartRatingView.swift
//  Rafi
//
//  Created by Noor Alhassani on 24/06/1447 AH.
//

internal import SwiftUI

struct HeartRatingView: View {
    let rating: Int   // 0...5
    let size: CGFloat

    private func assetName(for index: Int) -> String {
        // index = 1...5
        if index <= rating {
            // full
            return "Fullheart"
        } else {
            return "Midheart"
        }
    }

    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...5, id: \.self) { i in
                Image(assetName(for: i))
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            }
        }
    }
}
