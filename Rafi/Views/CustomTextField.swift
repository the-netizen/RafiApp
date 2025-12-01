//
//  CustomTextField.swift
//  Rafi
//
//  Created by Naima Khan on 01/12/2025.
//

import SwiftUI

struct CustomTextField: View {
    let labelText: String
    @Binding var textInput: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .foregroundColor(.white)
            
            HStack {
                Text(labelText)
                    .foregroundColor(.black.opacity(0.5))
                    .padding(.leading, 15)
                Divider().foregroundColor(.black)
            
            TextField("", text: $textInput)
                .foregroundColor(.black)
                .padding(.horizontal, 12)
                .autocorrectionDisabled()
                .autocapitalization(.none)
            }// hstack
        }// zstack
        .frame(height: 44)
    }
}

#Preview {
    // Use a wrapper to provide @State for the binding
    struct PreviewWrapper: View {
        @State var textF = "initial text"
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                CustomTextField(labelText: "Email:", textInput: $textF)
            }
            .padding()
        }
    }
    return PreviewWrapper()
}

