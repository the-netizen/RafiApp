//
//  ContentView.swift
//  Rafi
//
//  Created by Naima Khan on 30/11/2025.
//


import SwiftUI

struct MainView: View {
    @EnvironmentObject var session: UserSession
    @StateObject var viewModel = MainViewViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color("MainBackground")
                    .ignoresSafeArea()

                VStack(alignment: .center, spacing: 24) {

                    HStack {
                        VStack(alignment: .center, spacing: 6) {
                            Text("أهلاً وسهلاً!")
                                .font(.system(size: 28, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing,24)
                                .foregroundColor(.white)

                            Text("الاسم")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.9))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 24)
                        }

                        Spacer()

                        Image(session.avatarName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110, height: 110)   
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                            .shadow(radius: 4)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)

                     
                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 1)
                        .padding(.horizontal, 24)

                    // MARK: اختر تحديك
                    Text("اختر تحديك وابدأ رحلتك")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.top, -10)

                    // MARK: الكاتيقريز
                    VStack(spacing: 20) {
                        ForEach(viewModel.categories) { category in
                            CategoryCardView(category: category)
                        }
                    }
                    .padding(.top, 30)
                        }
                    }

                  
                }
            }
        }
 
