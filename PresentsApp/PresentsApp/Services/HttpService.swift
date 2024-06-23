import Foundation

class HttpService {
    private let baseUrl: String = "https://presents-app-backend-1-0-0.onrender.com"
    
    func httpRequest<ResponseType:Decodable>
    (method: String, url: String, responseType: ResponseType.Type, body: Data? = nil)
    async throws -> BaseHttpResponse<ResponseType> {
        guard let completeUrl = URL(string: "\(baseUrl)\(url)") else {
            print("Invalid URL: \(url)")
            throw GenericError.notValidUrl
        }
        
        var request = URLRequest(url: completeUrl)
        request.httpMethod = method
        
        if(body != nil){
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let decodedResponse = try JSONDecoder().decode(BaseHttpResponse<ResponseType>.self, from: data)
        
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode != 200 && httpResponse.statusCode != 201 {
                print("Server error: \(httpResponse.statusCode), \(String(data: data, encoding: .utf8) ?? "No response body")")
                throw ServerErrors.internalServerError
            }
            print("Successful server call at: \(url)")
        }
        
        return decodedResponse
    }
}
