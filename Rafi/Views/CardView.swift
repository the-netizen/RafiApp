
import SwiftUI

struct CardView: View {
    
    @StateObject var viewModel: CardViewViewModel
    @GestureState private var dragOffset: CGFloat = 0
    @Environment(\.dismiss) var dismiss //makes back button work
    
    init(viewModel: CardViewViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
//        print("CardView initialized with category: \(viewModel.category.rawValue)")
    }
    
    var body: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            
                VStack(spacing: 20) {
                    header
                    Spacer()
                    
                    cardStack
                        .frame(height: 480)
                        .padding(.bottom, 36)
                    
                    Spacer()
                } //VStack
                .padding(.horizontal)
        } //Zstack
        .navigationBarHidden(true) // cz we using custom header for navigation
        .navigationDestination(for: ChallengeCard.self) { card in
            ChallengeDetailView(card: card, category: viewModel.category)
        }
    } //body
    
    var cardStack: some View {
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
                                let swipeThreshold: CGFloat = 80
                                
                                // Allow both left and right swipes
                                if abs(value.translation.width) > swipeThreshold {
                                    viewModel.goNext()
                                }
                            }
                        : nil
                    )
            }
        } // Zstack
    } // card stack ends here
    
    var header: some View {
        CustomHeaderView(
            title: viewModel.category.title,
            iconName: viewModel.category.iconName,
            onBack: {
                dismiss()
            }
        )
        .frame(height: 170)
    }
}

// MARK: - CARD UI
struct ChallengeCardView: View {
    let card: ChallengeCard
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 6)
            
            Image(card.difficultyImageName)
                .resizable()
                .scaledToFit()
                .frame(height: 170)
                .opacity(0.70)
            
            VStack(spacing: 16) {
                Text(card.title)
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 40)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.center)
                Spacer()
                
                Text(card.description)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
//                    .lineLimit(3)
                
                Spacer()
                
                // nav to detail page
                NavigationLink(value: card) {
                    Text("start_button")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 56)
                        .padding(.vertical, 12)
                        .background(.button)
                        .cornerRadius(12)
                }
                .padding(.bottom, 40)
            }
            .frame(width: 310, height: 400)
        }
        .frame(width: 330, height: 420)
        .contentShape(Rectangle())
    }//body
}//challenge card ends here

// MARK: - PREVIEW MOCK
extension CardViewViewModel {
    static var previewMock: CardViewViewModel {
        let vm = CardViewViewModel(category: .outside)
        vm.cards = [
            ChallengeCard(difficultyImageName: "skull_level1",
                         titleKey: "outside_1_title", 
                         descriptionKey: "outside_1_description", 
                         conditionsKey: "outside_1_conditions"),
            ChallengeCard(difficultyImageName: "skull_level2",
                         titleKey: "outside_2_title", 
                         descriptionKey: "outside_2_description", 
                         conditionsKey: "outside_2_conditions")
        ]
        vm.currentIndex = 0
        return vm
    }
}

// MARK: - PREVIEW
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CardView(viewModel: .previewMock)
        }
//        .environment(\.layoutDirection, .rightToLeft)
    }
}

