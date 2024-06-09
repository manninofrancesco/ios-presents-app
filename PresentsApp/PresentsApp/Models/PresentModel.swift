//
//  PresentModel.swift
//  PresentsApp
//
//  Created by Francesco on 18/05/24.
//

import Foundation

struct PresentModel: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String = ""
    var description: String? = nil
    var link: String? = nil
    var userId: UUID? = nil
}
