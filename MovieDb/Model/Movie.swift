//
//  MovieModel.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 18/01/2023.
//

import Foundation

struct Movie: Codable {
    let backdropPath: String?
    let id: Int?
    let genreIds: [Int]?
    let title: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case genreIds = "genre_ids"
        case title
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
