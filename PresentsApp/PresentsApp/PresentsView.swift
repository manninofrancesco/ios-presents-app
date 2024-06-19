import SwiftUI

struct PresentsView: View {
    let userId: UUID?
    @StateObject private var presentService = PresentService()
    @State private var isAddPresentViewPresented:Bool = false
    
    init(userId: UUID? = nil) {
        self.userId = userId
    }
    
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
                    try await self.presentService.getUserPresents(inputUserId: self.userId)
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
                    try await self.presentService.getUserPresents(inputUserId: self.userId)
                }
            }
        }
        .contentMargins(20)
    }
}

#Preview {
    PresentsView()
}
