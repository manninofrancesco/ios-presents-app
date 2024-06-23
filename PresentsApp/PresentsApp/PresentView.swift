import SwiftUI

struct PresentView: View {
    let presentId: UUID
    @State var present: PresentModel?
    private var presentService = PresentService()
    private var userService = UserService()
    @State private var currentUser: UserModel?
    @State private var reservation: ReservationModel?
    @State private var loading: Bool = true
    
    init(presentId: UUID) {
        self.presentId = presentId
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if(present != nil){
                    Text(present!.description ?? "")
                }
                
                if(!loading && currentUser != nil && present?.userId != currentUser!.id){
                    if(reservation == nil){
                        Button() {
                            Task {
                                self.loading = true
                                reservation = try await bookPresent(presentId: present!.id)
                                self.loading = false
                            }
                        }
                    label: {
                        Text("Prenota")
                    }.buttonStyle(.borderedProminent)
                            .controlSize(.regular)
                    }
                    else{
                        if(reservation!.reserverUserId == currentUser?.id){
                            Text("Hai già prenotato questo regalo ✅")
                        }else{
                            Text("Prenotato 🔐")
                        }
                    }
                }
            }
            .padding()
            .navigationBarTitle(present?.title ?? "")
            .onAppear{
                Task {
                    try await loadPresent(presentId: presentId)
                    currentUser = try await self.userService.getCurrentUser()
                    reservation = try await self.presentService.getPresentReservation(presentID: presentId)
                    self.loading = false
                }
            }
        }
    }
    
    private func loadPresent(presentId: UUID) async throws {
        present = try await presentService.getPresent(id: presentId)
    }
    
    private func bookPresent(presentId: UUID) async throws -> ReservationModel {
        return try await presentService.bookPresent(presentID: presentId)
    }
}
