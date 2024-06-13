//
//  AddPresent.swift
//  PresentsApp
//
//  Created by Francesco on 10/06/24.
//

import SwiftUI

struct AddPresentView: View {
    @Environment (\.dismiss) var dismiss
    private var presentService = PresentService()
    private var userService = UserService()
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationStack {
            Form{
                Section{
                    TextField("Nome", text: $title)
                    TextField("Descrizione", text: $description)
                } header: {
                    Text("Dati regalo test")
                } footer: {
                    Button(){
                        Task {
                            let currentUser = try await self.userService.getCurrentUser()
                            let newPresent = PresentModel(
                                id: UUID(),
                                title: title, description: description, link: nil, userId: currentUser.id)
                            try await self.presentService.addPresent(model: newPresent)
                            try await self.presentService.getUserPresents()
                            dismiss()
                        }
                    }
                label: {
                    Text("Salva")
                }.buttonStyle(.borderedProminent)
                        .controlSize(.regular)
                }
            }
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

#Preview {
    AddPresentView()
}
