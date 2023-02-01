//
//  Reviews.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 01/02/2023.
//

import Foundation

struct Review: Codable {
    let authorDetails: Author
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case authorDetails = "author_details"
        case content
    }
}
