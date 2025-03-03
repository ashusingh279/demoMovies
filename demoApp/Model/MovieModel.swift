//
//  MovieModel.swift
//  demoApp
//
//  Created by Ashutosh Singh on 02/03/25.
//

import UIKit
 
struct Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double
    let genreIds: [Int]
    var imageData: Data?
    
    enum CodingKeys: String, CodingKey {
        case id, title, posterPath = "poster_path", backdropPath = "backdrop_path"
        case releaseDate = "release_date", overview, voteAverage = "vote_average"
        case voteCount = "vote_count", popularity, genreIds = "genre_ids"
    }
}
struct MovieResponse: Codable {
    let results: [Movie]
}
