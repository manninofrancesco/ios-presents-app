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
                            try await addNewPresent(userId: currentUser.id, title: self.title, description: self.description)
                            print("Complete adding a present")
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
                    Button() {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
    private func addNewPresent(userId: UUID, title: String, description: String) async throws {
        if(title == ""){
            throw PresentsErrors.missingTitle
        }
        let newPresent = PresentModel(
            id: UUID(),
            title: title, description: description, userId: userId)
        try await self.presentService.addPresent(model: newPresent)
        try await self.presentService.getUserPresents()
    }
}

#Preview {
    AddPresentView()
}
