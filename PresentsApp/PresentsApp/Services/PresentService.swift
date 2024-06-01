//
//  PresentService.swift
//  PresentsApp
//
//  Created by Francesco on 18/05/24.
//

import Foundation
import Combine

class PresentService: ObservableObject {
    @Published var presents: [PresentModel] = []
    private let baseUrl: String = "https://presents-app-production.up.railway.app"
    private let loggedUserId = "ca7d357e-c6c8-4b85-86b7-49eb492b3899"

    func getUserPresents() async throws
    {
        guard let url = URL(string: "\(baseUrl)/user/\(loggedUserId)/presents") else {
            print("Invalid URL")
            return
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(BaseHttpResponse<PresentModel>.self, from: data)
        
        await MainActor.run {
                    self.presents = decoded.data
        }
    }
}
