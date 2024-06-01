//
//  BaseHttpResponse.swift
//  PresentsApp
//
//  Created by Francesco on 18/05/24.
//



struct BaseHttpResponse<T: Decodable>: Decodable {
    let success: Bool
    let data: [T]
}
