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
        NavigationStack{
            List(presentService.presents) { present in
                Text(present.title)
            }
            .padding()
            .navigationTitle("I tuoi regali")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button("➕") {
                                        Task {
                                            do {
                                                try await addPresent()
                                            } catch {
                                                // Handle the error appropriately
                                                print("Failed to add present: \(error.localizedDescription)")
                                            }
                                        }
                                    }
                                }
            }
            .onAppear {
                Task {
                    try await presentService.getUserPresents()
                }
            }
        }
    }
    
    private func  addPresent() async throws {
        let newPresent = PresentModel(
            title: "New Present from IOS App",
            userId: UUID(uuidString: "ca7d357e-c6c8-4b85-86b7-49eb492b3899"))
        try await self.presentService .addPresent(model: newPresent)
    }
}

#Preview {
    PresentsView()
}
