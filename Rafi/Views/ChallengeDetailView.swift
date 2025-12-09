import SwiftUI

struct ChallengeDetailView: View {
    let card: ChallengeCard
    let category: MainCategory
    @Environment(\.dismiss) var dismiss
    
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
                    VStack(spacing: 20) {
                        
                        Text(card.title)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.top, 40)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 30)
                        
                        Text(card.conditions)
                            .font(.system(size: 20))
                            .padding(.horizontal, 30)
                            .padding(.bottom, 40)
                            .foregroundColor(.black.opacity(0.7))
                            .multilineTextAlignment(.leading)
                        
                    }
                }
                .padding(.vertical, 30)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(34)
                .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 5)
                .padding(.horizontal, 22)
                
                Spacer()
                Spacer()
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
        .navigationBarHidden(true)
    }
    
    
    // MARK: - HEADER
    private var header: some View {
        CustomHeaderView(
            title: category.rawValue,
            iconName: category.iconName,
            onBack: { dismiss() }
        )
        .frame(height: 170)
    } //header
}


// MARK: PREVIEW 1
struct ChallengeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChallengeDetailView(
                card: ChallengeCard(
                    title: "عدّل طلبي",
                    description: "اطلب شيئًا في مقهى ثم قم بتغييره.",
                    conditions: """
- يجب تغيير جزء من الطلب بشكل واضح (النوع، الإضافات، الحجم)
- كن مؤدبًا ومهذبًا مع الموظف
- لا تلغي الطلب بالكامل، فقط عدّله
""",
                    difficultyImageName: "skull_level1"
                ), category: .outside
            )
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}
