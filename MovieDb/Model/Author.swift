//
//  Author.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 01/02/2023.
//

import Foundation

struct Author: Codable {
    let name: String?
    let username: String?
    let avatarPath: String?
    let rating: Int?
    
    enum CodingKeys: String, CodingKey {
        case name, rating, username
        case avatarPath = "avatar_path"
    }
}
