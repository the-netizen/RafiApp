//
//  CardView.swift
//  Rafi
//
//  Created by Huda Chishtee on 01/12/2025.
//

import SwiftUI

struct CardView: View {

    @StateObject var viewModel = CardViewViewModel()
    @GestureState private var dragOffset: CGFloat = 0

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 195/255, green: 220/255, blue: 222/255)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    header
                    Spacer()

                    // CARD STACK
                    ZStack {
                        ForEach(viewModel.cards.indices, id: \.self) { index in
                            let card = viewModel.cards[index]
                            let isTop = index == viewModel.currentIndex

                            ChallengeCardView(card: card)
                                .offset(x: isTop ? dragOffset : 0,
                                        y: isTop ? 0 : CGFloat(index - viewModel.currentIndex) * 12)
                                .scaleEffect(isTop ? 1.0 : 0.96)
                                .rotationEffect(.degrees(isTop ? Double(dragOffset * 0.06) : 0))
                                .zIndex(Double(viewModel.cards.count - index))
                                .animation(.spring(response: 0.34, dampingFraction: 0.75),
                                           value: viewModel.currentIndex)
                                .gesture(
                                    isTop ?
                                    DragGesture()
                                        .updating($dragOffset) { value, state, _ in
                                            state = value.translation.width
                                        }
                                        .onEnded { value in
                                            if value.translation.width < -120 {
                                                viewModel.goNext()
                                            } else if value.translation.width > 120 {
                                                viewModel.goPrev()
                                            }
                                        }
                                    : nil
                                )
                        }
                    }
                    .frame(height: 480)
                    .padding(.bottom, 36)

                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationDestination(for: ChallengeCard.self) { card in
                ChallengeDetailView(card: card)
            }
        }
        .navigationViewStyle(.stack)
    }

    // ⭐ NEW FIXED HEADER
    private var header: some View {
        HStack {
            Button {
                // optional back action
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                    .padding(8)
                    .background(Color.white)
                    .clipShape(Circle())
            }

            Spacer()

            // ⭐ Sofa + title inside one capsule
            HStack(spacing: 10) {
                Image("sofa_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 24)

                Text("في المنزل")
                    .font(.system(size: 20, weight: .medium))
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 12)
            .background(Color.white)
            .cornerRadius(24)
            .shadow(color: .black.opacity(0.1), radius: 4, y: 2)

            Spacer()
        }
        .padding(.top, 44)
    }
}


/// CLEAN, UPGRADED CARD UI
struct ChallengeCardView: View {
    let card: ChallengeCard

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 6)

            VStack(spacing: 16) {

                // TITLE
                Text(card.title)
                    .font(.system(size: 26, weight: .bold))
                    .padding(.top, 12)
                    .multilineTextAlignment(.center)

                // DESCRIPTION
                Text(card.description)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                // IMAGE
                Image(card.difficultyImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 170)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.top, 6)
                    .opacity(0.95)

                Spacer()

                // BUTTON
                NavigationLink(value: card) {
                    Text("ابدأ")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 56)
                        .padding(.vertical, 12)
                        .background(Color.orange)
                        .cornerRadius(12)
                }
                .padding(.bottom, 20)
            }
            .frame(width: 310, height: 400)
        }
        .frame(width: 330, height: 420)
    }
}


// MARK: - Preview
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
            .previewDevice("iPhone 14 Pro")
            .environment(\.layoutDirection, .rightToLeft)
    }
}
