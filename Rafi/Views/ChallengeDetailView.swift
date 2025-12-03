//
//  ChallengeDetailView.swift
//  Rafi
//
//  Created by Huda Chishtee on 01/12/2025.
//

import SwiftUI

struct ChallengeDetailView: View {
    let card: ChallengeCard
    
    var body: some View {
        ZStack {
            // Background Color
                        Color("bgColor")
                            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                // HEADER
                HStack {
                    Button {
                        // Auto back handled by NavigationStack
                    } label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Text("في المنزل")
                        .font(.system(size: 22, weight: .medium))
                        .padding(.horizontal, 18)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(22)
                    
                    Image("sofa_icon")
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
                Spacer()
                
                // WHITE CARD
                VStack(spacing: 20) {
                    
                    // TITLE
                    Text(card.title)
                        .font(.system(size: 32, weight: .bold))
                        .multilineTextAlignment(.center)
                    
                    // DESCRIPTION (multi-line)
                    Text(card.description)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 12)
                    
                    // IMAGE
                    Image(card.difficultyImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180)
                        .padding(.top, 10)
                }
                .padding(.vertical, 30)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(34)
                .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 5)
                .padding(.horizontal, 22)
                
                Spacer()
                Spacer()
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
        .navigationBarHidden(true)
    }
}



// MARK: PREVIEW
struct ChallengeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChallengeDetailView(
                card: ChallengeCard(
                    title: "عنوان",
                    description: "نبذة عن التحدي\nنبذة عن التحدي\nنبذة عن التحدي\nنبذة عن التحدي",
                    difficultyImageName: "skull_level1"
                )
            )
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}
