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
    
    func fakeGetUserPresents() -> [PresentModel]{
        return [
            PresentModel(title: "Regalo 1"),
            PresentModel(title: "Regalo 2"),
            PresentModel(title: "Regalo 3")
        ]
    }

    /*func getUserPresents() async throws -> [PresentModel]
    {
        guard let url = URL(string: "\(baseUrl)/user/66003dbd-efa4-48fc-8590-2f671c43bdc3/presents") else {
            print("Invalid URL")
            return []
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(BaseHttpResponse<PresentModel>.self, from: data)
        
        return decoded.data
    }*/
}

