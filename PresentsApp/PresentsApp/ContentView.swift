import SwiftUI

struct ContentView: View {
    @StateObject var loginStatus = LoginStatus()
    
    var body: some View {
        if loginStatus.loggedUserId != nil {
            TabView {
                PresentsView()
                    .tabItem { Label("Regali", systemImage: "house") }
                SearchView()
                    .tabItem { Label("Cerca", systemImage: "magnifyingglass") }
                MyProfileView()
                    .environmentObject(loginStatus)
                    .tabItem { Label("Tu", systemImage: "person") }
            }
        }
        else{
            LoginView().environmentObject(loginStatus)
        }
    }
    
}

#Preview {
    ContentView()
}
