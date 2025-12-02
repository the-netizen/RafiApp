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
            Color(red: 195/255, green: 220/255, blue: 222/255)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                // MARK: - HEADER
                ZStack {
                    Color(red: 195/255, green: 220/255, blue: 222/255)
                        .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
                        .ignoresSafeArea(edges: .top)
                    
                    HStack(spacing: 18) {
                        
                        Button(action: {}) {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 10) {
                            Text("في المنزل")
                                .font(.system(size: 20, weight: .medium))
                            
                            Image("sofa_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 28)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 20)
                    .frame(height: 95)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.white, lineWidth: 4)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 28))
                    .padding(.top, 40)
                    .padding(.horizontal, 20)
                    .environment(\.layoutDirection, .leftToRight)  // FIX RTL flipping
                }
                .frame(height: 170)
            }
            
            
            
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
        .environment(\.layoutDirection, .rightToLeft)
        .navigationBarHidden(true)
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
}
