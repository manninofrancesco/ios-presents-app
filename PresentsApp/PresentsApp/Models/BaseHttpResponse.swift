struct BaseHttpResponse<T: Decodable>: Decodable {
    let success: Bool
    let data: [T]
}
