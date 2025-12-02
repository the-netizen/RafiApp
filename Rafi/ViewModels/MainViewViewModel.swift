//
//  MainViewViewModel.swift
//  Rafi
//
//  Created by Naima Khan on 30/11/2025.
//


import Foundation
import SwiftUI
import Combine

class MainViewViewModel: ObservableObject {
 
    @Published var userName: String = ""
    @Published var avatarName: String = "avatar1"


    let categories: [MainCategory] = [.home, .outside, .journal]

    func configure(name: String, avatar: String) {
        self.userName = name
        self.avatarName = avatar
    }
}
