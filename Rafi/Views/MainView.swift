internal import SwiftUI

struct MainView: View {
    @EnvironmentObject var session: UserSession
    @StateObject var viewModel = MainViewViewModel()
    
    // NEW: save selected icon & whether user picked before
    @AppStorage("selectedIcon") private var selectedIcon: String = "iconGirl"
    @AppStorage("hasPickedIcon") private var hasPickedIcon: Bool = false
    @State private var showPickIcon = false
    
    // NEW: save user name and control editing
    @AppStorage("userName") private var userName: String = "User"
    @State private var isEditingName = false
    @State private var tempUserName = ""
    @FocusState private var isNameFieldFocused: Bool

    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                Color("bgColor")
                    .ignoresSafeArea()
                    .onTapGesture {
                        if isEditingName {
                            saveUserName()
                        }
                    }
                
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
                                .padding(.leading, 20)
                                .foregroundColor(.white)
                            
                            HStack {
 
                                if isEditingName {
                                    TextField("Enter name", text: $tempUserName)
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.white)
                                        .textFieldStyle(.plain)
                                        .focused($isNameFieldFocused)
                                        .autocorrectionDisabled()
                                        .textInputAutocapitalization(.words)
                                        .onSubmit {
                                            saveUserName()
                                        }
                                        .background(
                                            Rectangle()
                                                .fill(Color.white.opacity(0.2))
                                                .frame(height: 1)
                                                .offset(y: 10)
                                        )
                                } else {
                                    
                                    Button {
                                        startEditingName()
                                    } label: {
                                        HStack(spacing: 6) {
                                            Text(userName)
                                                .font(.system(size: 18, weight: .medium))
                                                .foregroundColor(.white)
                                            
                                            Image(systemName: "pencil")
                                                .font(.system(size: 12, weight: .medium))
                                                .foregroundColor(.white.opacity(0.6))
                                        }
                                    }
                                }
                                
                                Spacer()
                            }
                            .padding(.leading, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
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
    
    // MARK: - Name Editing Functions
    private func startEditingName() {
        tempUserName = userName
        isEditingName = true
        isNameFieldFocused = true
    }
    
    private func saveUserName() {
        let trimmedName = tempUserName.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedName.isEmpty {
            userName = trimmedName
        }
        isEditingName = false
        isNameFieldFocused = false
    }
}

#Preview {
    MainView()
        .environment(\.locale, .init(identifier: "en"))
}
