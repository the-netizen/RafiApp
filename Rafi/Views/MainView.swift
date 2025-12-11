import SwiftUI

struct MainView: View {
    @EnvironmentObject var session: UserSession
    @StateObject var viewModel = MainViewViewModel()
<<<<<<< HEAD
    
=======


    // NEW: save selected icon & whether user picked before
    @AppStorage("selectedIcon") private var selectedIcon: String = "iconGirl"
    @AppStorage("hasPickedIcon") private var hasPickedIcon: Bool = false
    @State private var showPickIcon = false

>>>>>>> main
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                Color("bgColor")
                    .ignoresSafeArea()

                VStack(alignment: .center, spacing: 24) {
<<<<<<< HEAD
                    
                    // HEADER
=======

                    /// HEADER
>>>>>>> main
                    HStack {
                        VStack(alignment: .center, spacing: 6) {
                            Text("welcome_title")
                                .font(.system(size: 28, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing,24)
                                .foregroundColor(.white)
<<<<<<< HEAD
                            
                            Text("الاسم")
=======

                            Text("الاسم") // you can remove if you want
>>>>>>> main
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.9))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 24)
                        }

                        Spacer()
<<<<<<< HEAD
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 35)
                                .frame(width: 110, height: 110)
                                .foregroundColor(.white)
                            
                            Image("iconGirl")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    
=======

                        // icon (NOW CLICKABLE)
                        Button {
                            showPickIcon = true
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 35)
                                    .frame(width: 110, height: 110)
                                    .foregroundColor(.white)
                                
                                Image(selectedIcon)   // <-- now dynamic
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 90)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)


>>>>>>> main
                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 1)
                        .padding(.horizontal, 24)
<<<<<<< HEAD
                    
=======

                    // MARK: اختر تحديك
>>>>>>> main
                    Text("choose_challenge")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.top, 10)
<<<<<<< HEAD
                    
                    VStack(spacing: 20) {
                        ForEach(viewModel.categories) { category in
                            if category == .journal {
                                NavigationLink {
                                    JournalHistory()
                                } label: {
                                    CategoryCardView(category: category)
                                }
                                .buttonStyle(.plain)
                            } else {
                                Button {
                                    viewModel.navigateToCategory(category)
                                } label: {
                                    CategoryCardView(category: category)
                                }
                                .buttonStyle(.plain)
=======

                    /// CATEGORY BUTTONS
                    VStack(spacing: 20) {
                        ForEach(viewModel.categories) { category in
                            Button {
                                viewModel.navigateToCategory(category)
                            } label: {
                                CategoryCardView(category: category)

>>>>>>> main
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
<<<<<<< HEAD
=======


>>>>>>> main
            .navigationDestination(for: MainCategory.self) { category in
                CardView(viewModel: CardViewViewModel(category: category))
                    .environmentObject(viewModel)
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
<<<<<<< HEAD
=======
}

#Preview {
    MainView()



        .environment(\.locale, .init(identifier: "en"))

>>>>>>> main
}
