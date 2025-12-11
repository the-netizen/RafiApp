import SwiftUI

struct ChallengeDetailView: View {
    let card: ChallengeCard
    let category: MainCategory
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var mainViewModel: MainViewViewModel
    
    var body: some View {
        ZStack {
            
            // Background Color
            Color("bgColor")
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                // NEW HEADER
                header
                Spacer()
                
                ZStack{
                    
                    // IMAGE
                    Image(card.difficultyImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 170)
                        .opacity(0.70)
                    
                    // Text
                    VStack {
                        
                        Text(card.title)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(.label))
                            .padding(.top, 20)
                            .multilineTextAlignment(.center)
//                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 10)
                        
                        Text(card.conditions)
                            .font(.system(size: 20))
                            .foregroundColor(Color(.label).opacity(0.7))
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 40)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    
                        Spacer()
                        Button {
                            mainViewModel.navigationPath = NavigationPath()
                        } label: {
                            Text("Back to main menu")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .background(.button)
                                .cornerRadius(12)
                        }
                        .padding(.bottom, 20)
                    }
                    .frame(width: 330)
                }
                .frame(maxHeight: .infinity)
                .background(Color(.systemBackground))
                .cornerRadius(28)
                .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color(.secondaryLabel), lineWidth: 4)
                )
                .padding(.vertical, 20)
                .padding(.horizontal, 22)
                

                
                
                Spacer()
//                Spacer()
            }
        }
//        .environment(\.layoutDirection, .rightToLeft)
        .navigationBarHidden(true)
    }
    
    
    // MARK: - HEADER
    private var header: some View {
        CustomHeaderView(
            title: category.title,
            iconName: category.iconName,
            onBack: { dismiss() }
        )
        .frame(height: 170)
    } //header
} //body


// MARK: PREVIEW 1
struct ChallengeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChallengeDetailView(
                card: ChallengeCard(
                    difficultyImageName: "skull_level1",
                    titleKey: "outside_1_title",
                    descriptionKey: "outside_1_description",
                    conditionsKey: "outside_1_conditions")
                , category: .outside
            )
            .environmentObject(MainViewViewModel())
        }
    }
}
