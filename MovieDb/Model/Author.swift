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
    var avatarPath: String? = ""
    var rating: Float? = 0
    
    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
        case rating
        }
    
}
