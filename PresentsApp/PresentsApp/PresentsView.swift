import SwiftUI

struct PresentsView: View {
    let userId: UUID?
    @StateObject private var presentService = PresentService()
    @State private var isAddPresentViewPresented:Bool = false
    @State private var presents: [PresentModel]
    
    init(userId: UUID? = nil, presents: [PresentModel]? = nil) {
        self.userId = userId
        self.presents = presents ?? []
    }
    
    var body: some View {
        NavigationStack{
            List (presents) { present in
                Text(present.title)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            Task {
                                try await loadPresents()
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                
            }.refreshable {
                Task {
                    try await loadPresents()
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
                    try await loadPresents()
                }
            }
        }
        .contentMargins(20)
    }
    
    private func loadPresents() async throws {
        presents = try await presentService.getUserPresents(inputUserId: userId)
    }
}

#Preview {
    PresentsView()
}
