import Foundation

class HttpService {
    private let baseUrl: String = "https://presents-app-backend-1-0-0.onrender.com"
    
    func httpRequest<BodyType:Encodable, ResponseType:Decodable>(method: String, url: String, body: BodyType? = "", responseType: ResponseType.Type? = .none) async throws -> BaseHttpResponse<ResponseType> {
        guard let url = URL(string: "\(baseUrl)\(url)") else {
            print("Invalid URL: \(url)")
            throw GenericError.notValidUrl
        }
        
        var request = URLRequest(url : url)
        request.httpMethod = method
        
        if(body != nil && false){
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let decodedResponse = try JSONDecoder().decode(BaseHttpResponse<ResponseType>.self, from: data)
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode != 200 && httpResponse.statusCode != 201 {
                print("Server error: \(httpResponse.statusCode), \(String(data: data, encoding: .utf8) ?? "No response body")")
                throw ServerErrors.internalServerError
            }
        }
        
        return decodedResponse
    }
}
