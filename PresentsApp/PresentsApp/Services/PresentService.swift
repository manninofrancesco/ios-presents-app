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
    
    func addPresent(model: PresentModel) async throws
    {
        guard let url = URL(string: "\(baseUrl)/present/create") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        let jsonData = try JSONEncoder().encode(model)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("Success: \(String(data: data, encoding: .utf8) ?? "No response body")")
                } else {
                    print("Server error: \(httpResponse.statusCode)")
                }
            } else {
                print("Unknown response")
            }
    }
    
}
