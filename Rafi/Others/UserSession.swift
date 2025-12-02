//
//  UserSession.swift
//  Rafi
//
//  Created by Lyan on 10/06/1447 AH.
//

import SwiftUI
import Combine

class UserSession: ObservableObject {
    @Published var userName: String = ""
    @Published var avatarName: String = "avatar1"
}
