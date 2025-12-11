import SwiftUI

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

                    /// HEADER
                    HStack {
                        VStack(alignment: .center, spacing: 6) {
                            Text("welcome_title")
                                .font(.system(size: 28, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing,24)
                                .foregroundColor(.white)

                            Text("الاسم") // you can remove if you want
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.9))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 24)
                        }

                        Spacer()

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


                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 1)
                        .padding(.horizontal, 24)

                    // MARK: اختر تحديك
                    Text("choose_challenge")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.top, 10)

                    /// CATEGORY BUTTONS
                    VStack(spacing: 20) {
                        ForEach(viewModel.categories) { category in
                            Button {
                                viewModel.navigateToCategory(category)
                            } label: {
                                CategoryCardView(category: category)

                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }


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
}

#Preview {
    MainView()



        .environment(\.locale, .init(identifier: "en"))

}
