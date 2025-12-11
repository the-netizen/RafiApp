//
//  CustomHeaderView\.swift
//  Rafi
//
//  Created by Naima Khan on 07/12/2025.
//

import SwiftUI

struct CustomHeaderView: View {
    let title: String
    let iconName: String
    let onBack: () -> Void
    
    var body: some View {
        ZStack{
            HStack {
                // back button
                Button(action: {
                    onBack()
                }) {
                    ZStack{
                        Circle()
//                            .background(.backButton)
                            .foregroundColor(.backButton)
//                            .clipShape(Circle())
                            .frame(width: 40)
                        
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .padding(10)
                    }
                }
                
                Spacer()
                
                // title + icon
                HStack(spacing: 20) {
//                    Image(iconName)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 40)
                    
                    Text(title)
                        .font(.system(size: 25, weight: .medium))
                        .foregroundColor(.black)
                    
                    //                        .padding(.trailing, -50)
                    
                }
                Spacer(minLength: 5)
            }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, minHeight: 95)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color.white, lineWidth: 4)
                )
                .clipShape(RoundedRectangle(cornerRadius: 28))
                .padding(.top, 40)
                .padding(.horizontal, 20)
                .environment(\.layoutDirection, .leftToRight)
        } //zstack
    } //body
}

