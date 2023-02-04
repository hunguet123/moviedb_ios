//
//  ReviewsResponse.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 01/02/2023.
//

import Foundation

struct ReviewResponse: Codable {
    let id: Int
    let page: Int?
    let results: [Review]?
    
    enum CodingKeys: String, CodingKey {
        case id, page, results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.page = try container.decodeIfPresent(Int.self, forKey: .page)
        self.results = try container.decode([Review].self, forKey: .results)
    }
}
