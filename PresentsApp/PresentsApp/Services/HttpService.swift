//
//  HttpService.swift
//  PresentsApp
//
//  Created by Francesco on 11/06/24.
//

import Foundation

class HttpService {
    func httpRequest(url: String, method: String) async throws {
        guard let url = URL(string: url) else {
            print("Invalid URL: \(url)")
            return
        }
        
        var request = URLRequest(url : url)
        request.httpMethod = method
        try await baseHttpRequest(request: request)
    }
    
    func httpRequest<T:Encodable>(url: String, body: T, method: String) async throws {
        guard let url = URL(string: url) else {
            print("Invalid URL: \(url)")
            return
        }
        
        var request = URLRequest(url : url)
        request.httpMethod = method
        
        let jsonData = try JSONEncoder().encode(body)
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        try await baseHttpRequest(request: request)
    }
    
    private func baseHttpRequest(request: URLRequest) async throws {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                print("Success: \(String(data: data, encoding: .utf8) ?? "No response body")")
            } else {
                print("Server error: \(httpResponse.statusCode), \(String(data: data, encoding: .utf8) ?? "No response body")")
            }
        } else {
            print("Unknown response")
        }
    }
}
