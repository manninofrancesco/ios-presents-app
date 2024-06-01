//
//  PresentsView.swift
//  PresentsApp
//
//  Created by Francesco on 01/06/24.
//

import SwiftUI

struct PresentsView: View {
    @StateObject private var presentService = PresentService()
    
    var body: some View {
        let userPresents = presentService.fakeGetUserPresents()
        NavigationView {
            List(userPresents) { present in
                Text(present.title)
            }
            .padding()
            .navigationBarTitle("I tuoi regali")
        }
    }
}

#Preview {
    PresentsView()
}
