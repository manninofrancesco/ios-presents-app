import Foundation

class HttpService {
    private let baseUrl: String = "https://presents-app-backend-1-0-0.onrender.com"
    
    func httpRequest<ResponseType:Decodable>
    (method: String, url: String, responseType: ResponseType.Type, body: Data? = nil, authToken: String? = nil)
    async throws -> BaseHttpResponse<ResponseType> {

        do {
            guard let completeUrl = URL(string: "\(baseUrl)\(url)") else {
                print("Invalid URL: \(url)")
                throw GenericError.notValidUrl
            }
            
            print("API Call: \(url)")
            
            var request = URLRequest(url: completeUrl)
            request.httpMethod = method
            
            if(body != nil){
                request.httpBody = body
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            if let token = authToken {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
                   
            let (data, response) = try await URLSession.shared.data(for: request)

            if let httpResponse = response as? HTTPURLResponse {
                print("Server response: \(httpResponse.statusCode), \(String(data: data, encoding: .utf8) ?? "No response body")")
            }
            
            let decodedResponse = try JSONDecoder().decode(BaseHttpResponse<ResponseType>.self, from: data)
            
            return decodedResponse
        }
        catch {
            print("HttpService error: \(error)")
            throw ServerErrors.internalServerError
        }
    }
}
