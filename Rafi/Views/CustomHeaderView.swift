//
//  CustomHeaderView\.swift
//  Rafi
//
//  Created by Naima Khan on 07/12/2025.
//

internal import SwiftUI

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
//                    ZStack{
//                        Circle()
//                            .background(.backButton)
//                            .foregroundColor(.backButton)
//                            .clipShape(Circle())
//                            .frame(width: 40)
                        
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .padding(10)
//                    }
                }
                
                Spacer().frame(width: 25)
                
                // title + icon
                HStack(spacing: 25) {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                    
                    Text(title)
                        .font(.system(size: 25, weight: .medium))
                        .foregroundColor(Color(.label))
                    
                    //                        .padding(.trailing, -50)
                    
                }
                Spacer(minLength: 5)
            }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, minHeight: 95)
                .background(Color(.systemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color(.secondaryLabel), lineWidth: 8)
                )
                .clipShape(RoundedRectangle(cornerRadius: 28))
                .padding(.top, 40)
                .padding(.horizontal, 20)
                .environment(\.layoutDirection, .leftToRight)
        } //zstack
    } //body
}

