internal import SwiftUI

struct MainView: View {
    @EnvironmentObject var session: UserSession
    @StateObject var viewModel = MainViewViewModel()

    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                Color("bgColor")
                    .ignoresSafeArea()

                VStack(alignment: .center, spacing: 24) {

                    // HEADER
                    HStack {
                        VStack(alignment: .center, spacing: 6) {
                            Text("welcome_title")
                                .font(.system(size: 28, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 24)
                                .foregroundColor(.white)

                            Text("الاسم")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.9))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 24)
                        }

                        Spacer()

                        // icon
                        ZStack {
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
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environment(\.locale, .init(identifier: "en"))
}
