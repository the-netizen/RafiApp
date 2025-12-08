
import SwiftUI

@main
struct RafiApp: App {
    @StateObject var session = UserSession()

    var body: some Scene {
        WindowGroup {
            NavigationStack{
                MainView()
                    .environmentObject(session)
            }
        }
    }
}
