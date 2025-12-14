internal import SwiftUI

struct MainView: View {
    @EnvironmentObject var session: UserSession
    @StateObject var viewModel = MainViewViewModel()
    
    // NEW: save selected icon & whether user picked before
    @AppStorage("selectedIcon") private var selectedIcon: String = "iconGirl"
    @AppStorage("hasPickedIcon") private var hasPickedIcon: Bool = false
    @State private var showPickIcon = false

    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                Color("bgColor")
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 24) {
                    
                    // HEADER
                    HStack {
                        // icon (NOW CLICKABLE) - moved to left
                        Button {
                            showPickIcon = true
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 35)
                                    .frame(width: 110, height: 110)
                                    .foregroundColor(Color(.systemBackground).opacity(0.2))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 28)
                                            .stroke(Color(.systemBackground), lineWidth: 4)
                                    )
                                
                                Image(selectedIcon)   // <-- now dynamic
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120)
                            }
                        }
                        .buttonStyle(.plain)
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 6) {
                            Text("welcome_title")
                                .font(.system(size: 28, weight: .bold))
                                .frame(maxWidth: .infinity, alignment:.leading)
                                .padding(.trailing, 24)
                                .foregroundColor(.white)
                            
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 60)
                    
                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 1)
                        .padding(.horizontal, 24)
                    
                    // اختر تحديك
                    Text("choose_challenge")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.top, 10)
                    
                    // CATEGORY BUTTONS
                    VStack(spacing: 29) {
                        ForEach(viewModel.categories) { category in
                            Button {
                                viewModel.navigateToCategory(category)
                            } label: {
                                CategoryCardView(category: category)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                    Spacer()
                }
            }
            // 👉 decide which screen to show for each category
            .navigationDestination(for: MainCategory.self) { category in
                switch category {
                case .journal:
                    // our new recording list screen
                    JournalHistory()
                    
                default:
                    // old card-stack flow for Home / Outside, etc.
                    CardView(viewModel: CardViewViewModel(category: category))
                        .environmentObject(viewModel) // Pass the MainViewViewModel
                }
            }
            
            // SHOW PICK ICON SHEET
            .sheet(isPresented: $showPickIcon, onDismiss: {
                hasPickedIcon = true
            }) {
                PickIconView(selectedIcon: $selectedIcon)
            }
            
            // FIRST LAUNCH LOGIC
            .onAppear {
                if !hasPickedIcon {
                    showPickIcon = true
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environment(\.locale, .init(identifier: "en"))
}
