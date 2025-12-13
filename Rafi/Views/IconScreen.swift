internal import SwiftUI

struct PickIconView: View {
    let icons = [
        "iconGirlHat", "iconBoy", "iconBoyGlasses",
        "iconGirl", "iconBoyOld", "iconGirlOrange"
    ]
    
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedIcon: String

    var body: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Pick an Icon")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)

                Spacer()
                
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 20),
                        GridItem(.flexible(), spacing: 20)
                    ],
                    spacing: 25
                ) {
                    ForEach(icons, id: \.self) { icon in
                        Button {
                            selectedIcon = icon
                            dismiss()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundColor(.white)
                                    .frame(width: 120, height: 120)
                                    .shadow(color: .black.opacity(0.15), radius: 4)
                                
                                Image(icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 45)
                
                Spacer()
                
                Button(action: { dismiss() }) {
                    Text("Enter")
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
