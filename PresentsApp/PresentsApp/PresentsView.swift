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
            VStack {
                if(presents.isEmpty){
                    Text("La tua lista è vuota 🥲")
                }else{
                    List (presents) { present in
                        NavigationLink(present.title, destination: EditPresentView(present: present))
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    Task {
                                        try await deletePresent(id: present.id )
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
                        EditPresentView()
                    }
                }
            }
            .onAppear {
                Task {
                    try await loadPresents()
                }
            }
            .onChange(of: isAddPresentViewPresented) {
                if !isAddPresentViewPresented {
                    Task {
                        try await loadPresents()
                    }
                }
            }
            
        }
        .contentMargins(20)
    }
    
    private func loadPresents() async throws {
        presents = try await presentService.getUserPresents(inputUserId: userId)
    }
    
    private func deletePresent(id: UUID) async throws {
        try await presentService.deletePresent(id: id)
    }
}

#Preview {
    PresentsView()
}
