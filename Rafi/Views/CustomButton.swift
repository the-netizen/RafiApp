
import SwiftUI

struct CustomButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 14)
                    .foregroundColor(.button)
                    .frame(width: 150, height: 50)
                
                Text(title)
                    .foregroundColor(.primary)
            }
        }
//        .buttonStyle(.glass)
        .buttonStyle(PressableButtonStyle())

    }
}

struct PressableButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .opacity(configuration.isPressed ? 0.85 : 1.0)
    }
    
}

#Preview {
    CustomButton(title: "Button") {
        // action
    }
}
