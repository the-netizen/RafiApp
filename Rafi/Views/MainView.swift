import SwiftUI

struct MainView: View {
    @EnvironmentObject var session: UserSession
    @StateObject var viewModel = MainViewViewModel()
    //    @State private var selectedCategory: MainCategory?
    
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                Color("bgColor")
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 24) {
                    
                    /// HEADER
                    HStack {
                        VStack(alignment: .center, spacing: 6) {
                            Text("أهلاً وسهلاً!")
                                .font(.system(size: 28, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing,24)
                                .foregroundColor(.white)
                            
                            Text("الاسم")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.9))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 24)
                        }
                        
                        Spacer()
                        
                        // icon
                        ZStack{
                            RoundedRectangle(cornerRadius: 35)
                                .frame(width: 110, height: 110)
                                .foregroundColor(.white)
                            
                            // chosen image will become the icon
                            Image("iconGirl")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90)
                        }
                        
                    } //Hstack header ends
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    
                    
                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 1)
                        .padding(.horizontal, 24)
                    
                    // MARK: اختر تحديك
                    Text("اختر تحديك وابدأ رحلتك")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.top, 10)
                    
                    /// CATEGORY BUTTONS
                    // MARK: الكاتيقريز
                    VStack(spacing: 20) {
                        ForEach(viewModel.categories) { category in
                            Button {
//                                print("Button tapped for category: \(category.rawValue)")
                                viewModel.navigateToCategory(category)
                            } label: {
                                CategoryCardView(category: category)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                } //Vstack
            } //zstack
            .navigationDestination(for: MainCategory.self) { category in
                CardView(viewModel: CardViewViewModel(category: category))
            }
        } //navigationStack
    } //body
} //main view
 
#Preview {
    let mockSession = UserSession()

    return MainView()
        .environmentObject(mockSession)
}

