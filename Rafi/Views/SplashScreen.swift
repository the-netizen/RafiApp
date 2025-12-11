import SwiftUI

struct SplashViewBounce: View {
    @State private var showSplash = true
    @State private var bounce = false

    var body: some View {
        ZStack {
            MainView() // Always behind the splash

            if showSplash {
                Color(#colorLiteral(red: 0.694, green: 0.827, blue: 0.835, alpha: 1))
                    .ignoresSafeArea()
                    .overlay(
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
                    )
                    .transition(.opacity) // Smooth fade out
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(.easeOut(duration: 0.5)) {
                                showSplash = false
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    SplashViewBounce()
}
