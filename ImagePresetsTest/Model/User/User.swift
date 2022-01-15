//
//  User.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 15.01.22.
//

import Foundation

struct User {
    let id: String
    let userName: String
    let photoUrl: String
    let userUrl: String
    let colors: [String]
}

extension User: Codable {
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(User.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
    private enum CodingKeys: String, CodingKey {
        case id
        case userName = "user_name"
        case photoUrl = "photo_url"
        case userUrl = "user_url"
        case colors
    }
}
