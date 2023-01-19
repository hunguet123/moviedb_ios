//
//  MoviesResponse.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 18/01/2023.
//

import Foundation

struct MoviesResponse: Codable {
    let page: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page, results
    }
}
