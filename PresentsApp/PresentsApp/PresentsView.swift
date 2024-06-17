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
            List (presentService.presents) { present in
                Text(present.title)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            Task {
                                try await self.presentService.deletePresent(id: present.id)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                
            }.refreshable {
                Task {
                    try await self.presentService.getUserPresents()
                }
            }
            
            .navigationTitle("🎁 I tuoi regali")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button() {
                        isAddPresentViewPresented.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.gray)
                    }.sheet(isPresented: $isAddPresentViewPresented) {
                        AddPresentView()
                    }
                }
            }
            .onAppear {
                Task {
                    try await self.presentService.getUserPresents()
                }
            }
        }
        .contentMargins(20)
    }
}

#Preview {
    PresentsView()
}
