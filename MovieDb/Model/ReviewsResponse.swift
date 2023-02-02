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
}
