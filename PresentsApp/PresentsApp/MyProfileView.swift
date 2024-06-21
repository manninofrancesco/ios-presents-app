import SwiftUI

struct MyProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Il tuo profilo")
            }
            .padding()
            .navigationBarTitle("Tu")
        }
    }
}
