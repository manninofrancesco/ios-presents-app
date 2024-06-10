//
//  PresentsView.swift
//  PresentsApp
//
//  Created by Francesco on 01/06/24.
//

import SwiftUI

struct PresentsView: View {
    @StateObject private var presentService = PresentService()
    @State private var isAddPresentViewPresented:Bool = false
    
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
                        /*Task {
                            try await addPresent()
                        }*/
                        isAddPresentViewPresented.toggle()
                    }.sheet(isPresented: $isAddPresentViewPresented) {
                        AddPresentView()
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
    
    struct AddPresentView: View {
        @Environment (\.dismiss) var dismiss
        var body: some View {
            NavigationStack {
                Text("Add Present Form")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("❌") {
                                dismiss()
                            }
                        }
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
