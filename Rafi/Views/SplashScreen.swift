internal import SwiftUI

struct SplashViewBounce: View {
    @State private var showSplash = true
    @State private var bounce = false

    var body: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()

            if showSplash {
                VStack(spacing: 50) {
                    Text("TALEQ")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                        .kerning(2)

                    Image("iconGirlHat")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 190)
                        .offset(y: bounce ? -10 : 10)
                        .onAppear {
                            withAnimation(Animation
                                .easeInOut(duration: 0.3)
                                .repeatCount(30, autoreverses: true)) {
                                    bounce.toggle()
                            }
                        }
                }
                .transition(.opacity)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation(.easeOut(duration: 0.3)) {
                            showSplash = false
                        }
                    }
                }
            } else {
                // Show main view after splash
                MainView()
                    .transition(.opacity)
            }
        }
    }
}

#Preview {
    SplashViewBounce()
}
