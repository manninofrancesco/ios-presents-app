import SwiftUI

struct PresentView: View {
    let presentId: UUID
    @State var present: PresentModel?
    private var presentService = PresentService()
    
    init(presentId: UUID) {
        self.presentId = presentId
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if(present != nil){
                    Text(present!.description ?? "")
                }
            }
            .padding()
            .navigationBarTitle(present?.title ?? "")
            .onAppear{
                Task {
                    try await loadPresent(presentId: presentId)
                }
            }
        }
    }
    
    private func loadPresent(presentId: UUID) async throws {
        present = try await presentService.getPresent(id: presentId)
    }
}
