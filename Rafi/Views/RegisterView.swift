//
//  RegisterView.swift
//  Rafi
//
//  Created by Naima Khan on 30/11/2025.
//

import SwiftUI

struct RegisterView: View {
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack{
            // choosing icon
            Text("Choose your icon!")
                .foregroundColor(.red)
                .padding(.top, 60)
                .padding(.bottom, 20)
            
            VStack(spacing: 20){
                HStack(spacing:20){
                    RoundedRectangle(cornerRadius: 20)
                    RoundedRectangle(cornerRadius: 20)
                    RoundedRectangle(cornerRadius: 20)
                }
                HStack(spacing: 20){
                    RoundedRectangle(cornerRadius: 20)
                    RoundedRectangle(cornerRadius: 20)
                    RoundedRectangle(cornerRadius: 20)
                }
            }// icons
            .frame(height: 200)
            .padding(.bottom, 60)
            .padding(.horizontal,50)
            
            VStack(spacing: 20){
                CustomTextField(labelText: "AppleID", textInput: $email)
                CustomTextField(labelText: "Username", textInput: $username)
                CustomTextField(labelText: "Password", textInput: $password)
            }.frame(width: 300, height: 200)
                .padding(.bottom, 50)
            
            CustomButton(title: "Register") {
                //
            }
            
            Spacer()
        }//main stack
        .background(.bg)
    }
}

#Preview {
    RegisterView(email: "email", username: "username", password: "password")
}
