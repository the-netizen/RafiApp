//
//  CardView.swift
//  Rafi
//
//  Created by Huda Chishtee on 01/12/2025.
//

import SwiftUI

struct CardView: View {

    @StateObject var viewModel: CardViewViewModel
    @GestureState private var dragOffset: CGFloat = 0

    init(viewModel: CardViewViewModel = CardViewViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("bgColor")
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    header
                    Spacer()

                    ZStack {
                        ForEach(viewModel.cards.indices, id: \.self) { index in
                            let card = viewModel.cards[index]
                            let isTop = index == viewModel.currentIndex

                            ChallengeCardView(card: card)
                                .offset(
                                    x: isTop ? dragOffset : 0,
                                    y: isTop ? 0 : CGFloat(index - viewModel.currentIndex) * 12
                                )
                                .scaleEffect(isTop ? 1.0 : 0.96)
                                .rotationEffect(.degrees(isTop ? Double(dragOffset * 0.06) : 0))
                                .zIndex(isTop ? Double(viewModel.cards.count + 100 - index) : Double(viewModel.cards.count - index))
                                .allowsHitTesting(isTop)
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
    }

    // MARK: - HEADER
    private var header: some View {
        ZStack {
//            Color(Color.red)
//                .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
//                .ignoresSafeArea(edges: .top)

            HStack(spacing: 18) {

                Button(action: {}) {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                }

                Spacer()

                HStack(spacing: 20) {
                    Text("خارج المنزل")
                        .font(.system(size: 25, weight: .medium))

                    Image("tree_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(.trailing,-50)
                }

                Spacer(minLength: 5)
            }
            .padding(.horizontal, 20)
            .frame(height: 95)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(Color.white, lineWidth: 4)
            )
            .clipShape(RoundedRectangle(cornerRadius: 28))
            .padding(.top, 40)
            .padding(.horizontal, 20)
            .environment(\.layoutDirection, .leftToRight)
        }
        .frame(height: 170)
    }

    // MARK: - CARD UI
    struct ChallengeCardView: View {
        let card: ChallengeCard

        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 6)

                VStack(spacing: 16) {
                    Text(card.title)
                        .font(.system(size: 26, weight: .bold))
                        .padding(.top, 12)
                        .multilineTextAlignment(.center)

                    Text(card.description)
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)

                    Image(card.difficultyImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 170)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.top, 6)
                        .opacity(0.95)

                    Spacer()

                    NavigationLink(value: card) {
                        Text("ابدأ")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 56)
                            .padding(.vertical, 12)
                            .background(.button)
                            .cornerRadius(12)
                    }
                    .padding(.bottom, 20)
                }
                .frame(width: 310, height: 400)
            }
            .frame(width: 330, height: 420)
            .contentShape(Rectangle())   // ← FIX: makes button fully tappable
        }
    }
}

// MARK: - PREVIEW MOCK
extension CardViewViewModel {
    static var previewMock: CardViewViewModel {
        let vm = CardViewViewModel()
        vm.cards = [
            ChallengeCard(title: "عدّل طلبي  ", description: "اذهب إلى مطعم أو مقهى، واطلب شيئًا، ثم بعد ثوانٍ قم بتغيير الطلب. ", difficultyImageName: "skull_level1"),
            ChallengeCard(title: "عنوان تجريبي 2", description: "وصف أطول قليلاً", difficultyImageName: "skull_level2")
        ]
        vm.currentIndex = 0
        return vm
    }
}

// MARK: - PREVIEW
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(viewModel: .previewMock)
            .environment(\.layoutDirection, .rightToLeft)
    }
}
