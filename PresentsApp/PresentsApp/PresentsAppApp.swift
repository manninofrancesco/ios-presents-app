import SwiftUI

@main
struct PresentsAppApp: App {
    @StateObject private var loginStatus = LoginStatus()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginStatus)
        }
    }
}
