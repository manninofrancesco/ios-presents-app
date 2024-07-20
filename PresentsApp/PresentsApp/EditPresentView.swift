import SwiftUI

struct EditPresentView: View {
    @Environment (\.dismiss) var dismiss
    private var presentService = PresentService()
    private var userService = UserService()
    @State private var present: PresentModel? = nil
    @State private var title: String
    @State private var description: String
    
    init(present: PresentModel? = nil) {
        self.present = present
        self.title = present?.title ?? ""
        self.description = present?.description ?? ""
    }
    
    var body: some View {
        NavigationStack {
            Form{
                Section{
                    TextField("Nome", text: $title)
                    TextField("Descrizione", text: $description)
                }
                footer: {
                    Button(){
                        Task {
                            let currentUser = try await self.userService.getCurrentUser()
                            if(currentUser != nil){
                                try await savePresent(userId: currentUser!.id,  present: self.present)
                                dismiss()
                            }
                        }
                    }
                label: {
                    Text("Salva")
                }.buttonStyle(.borderedProminent)
                        .controlSize(.regular)
                }
            }
            .navigationTitle("Modifica")
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
            .onAppear {
                Task {
                        try await loadPresent()
                }
            }
        }
    }
    
    private func loadPresent() async throws {
        if(present != nil){
            self.title = present!.title
            self.description = present!.description ?? ""
        }
    }
    
    private func savePresent(userId: UUID, present: PresentModel? = nil)
    async throws {
        if(self.title == ""){
            throw PresentsErrors.missingTitle
        }
        
        if(present != nil){
            self.present?.title = self.title
            self.present?.description = self.description
            try await self.presentService.updatePresent(model: self.present!)
        }else{
            let newPresent = PresentModel(
                id: UUID(),
                title: self.title, description: self.description, userId: userId)
            try await self.presentService.addPresent(model: newPresent)
        }
    }
}

#Preview {
    EditPresentView()
}
