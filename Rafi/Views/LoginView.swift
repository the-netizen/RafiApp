
import SwiftUI

struct LoginView: View {
    @StateObject private var vm = LoginViewViewModel()
    
    // hard-coded mint color (no asset)
    private let mintBackground = Color(red: 0.48, green: 0.71, blue: 0.69)
    
    var body: some View {
        ZStack {
            mintBackground
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                Text("APPNAME")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                Image("GirlIcon")          // make sure asset name is GirlIcon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 10)
                
                TextField("اسم المستخدم", text: $vm.username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal, 40)
                
                SecureField("كلمة المرور", text: $vm.password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal, 40)
                
                Button(action: vm.login) {
                    Text("دخول")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(20)
                }
                .padding(.horizontal, 70)
                .padding(.top, 10)
                
                if let error = vm.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, 8)
                }
                
                Spacer()
            }
        }
    }
}
