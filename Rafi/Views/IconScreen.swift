import SwiftUI

struct PickIconView: View {
    let icons = [
        "iconGirlHat", "iconBoy", "iconBoyGlasses",
        "iconGirl", "iconBoyOld", "iconGirlOrange"
    ]
    
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedIcon: String // <-- Binding from MainView
    
    var body: some View {
        ZStack {
            Color(red: 0.73, green: 0.88, blue: 0.89)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Title
                Text("Pick an Icon")
                    .font(.system(size: 26))
                
                Spacer()
                
                // Grid
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 20),
                        GridItem(.flexible(), spacing: 20)
                    ],
                    spacing: 25
                ) {
                    ForEach(icons, id: \.self) { icon in
                        Button {
                            selectedIcon = icon // Update MainView icon
                            dismiss() // Close sheet
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .frame(width: 120, height: 120)
                                    .shadow(color: .black.opacity(0.15), radius: 4)
                                
                                Image(icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 45)
                
                Spacer()
                
                // Optional: keep this button if you want a confirmation instead of tap-to-select
                Button(action: {
                    dismiss()
                }) {
                    Text("دخول")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                        .frame(width: 150, height: 50)
                        .background(Color.orange)
                        .cornerRadius(14)
                }
                .padding(.bottom, 80)
            }
        }
    }
}

struct PickIconView_Previews: PreviewProvider {
    static var previews: some View {
        PickIconView(selectedIcon: .constant("iconGirl"))
    }
}
