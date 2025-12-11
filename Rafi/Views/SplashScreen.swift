//
//  SplashScreen_Bounce.swift
//  Rafi
//

import SwiftUI

struct SplashViewBounce: View {
    @State private var isActive = false
    @State private var bounce = false

    var body: some View {
        ZStack {
            if isActive {
                MainView()
            } else {
                splashContent
            }
        }
        .onAppear {
            // Navigate to MainView after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut(duration: 0.6)) { isActive = true }
            }
        }
    }

    private var splashContent: some View {
        ZStack {
            Color(#colorLiteral(red: 0.694, green: 0.827, blue: 0.835, alpha: 1))
                .ignoresSafeArea()

            VStack(spacing: 80) {
                Text("APPNAME")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .kerning(2)

                Image("iconGirlHat")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 190)
                    .offset(y: bounce ? -10 : 10)
                    .onAppear {
                        withAnimation(Animation
                            .easeInOut(duration: 0.4)
                            .repeatForever(autoreverses: true)) {
                                bounce.toggle()
                        }
                    }
            }
        }
    }
}

#Preview {
    SplashViewBounce()
}
