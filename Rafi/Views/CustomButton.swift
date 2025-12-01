//
//  CustomButton.swift
//  Rafi
//
//  Created by Naima Khan on 01/12/2025.
//

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

    }
}

#Preview {
    CustomButton(title: "Button") {
        // action
    }
}
