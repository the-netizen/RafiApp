//
//  CategoryCardView.swift
//  Rafi
//
//  Created by Lyan on 10/06/1447 AH.
//

import SwiftUI

struct CategoryCardView: View {
    let category: MainCategory

    @State private var isPressed = false
    @State private var animate = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 3)

            HStack {
                Spacer()

                Image(category.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)   // ايقونة أصغر شوي
                    .scaleEffect(animate ? 1.06 : 1.0)
                    .animation(.easeInOut(duration: 1.2).repeatForever(), value: animate)
            }
            .padding(.horizontal, 22)

            Text(category.rawValue)
                .font(.system(size: 24, weight: .semibold))   // خط أصغر بشوي
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(width:330)
        .frame(height: 130)   // ← هنا تصغير المستطيل
        .scaleEffect(isPressed ? 0.96 : 1.0)
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isPressed = false
            }
        }
        .onAppear {
            animate = true
        }
    }
}
