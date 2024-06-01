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
        NavigationView {
            List(presentService.presents) { present in
                Text(present.title)
            }
            .padding()
            .navigationBarTitle("I tuoi regali")
            .onAppear {
                Task {
                    try await presentService.getUserPresents()
                }
            }
        }
    }
}

#Preview {
    PresentsView()
}
