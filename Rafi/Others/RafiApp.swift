//
//  RafiApp.swift
//  Rafi
//
//  Created by Naima Khan on 30/11/2025.
//

import SwiftUI

@main
struct RafiApp: App {
    @StateObject var session = UserSession()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(session)
        }
    }
}
