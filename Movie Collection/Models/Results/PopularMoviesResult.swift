//
//  PopularMoviesResult.swift
//  Movie Collection
//
//  Created by BarisSaglam on 28.07.2019.
//  Copyright © 2019 BarisSaglam. All rights reserved.
//

import Foundation

struct PopularMoviesResult: Codable {
    let voteCount : Int?
    let id: Int?
    let video: Bool?
    let voteAverage: Float?
    let title: String?
    let popularity: Float?
    let posterPath: String?
    let genreIDs: [Int]?
    let backdropPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: String?
}

extension PopularMoviesResult{
    enum CodingKeys: String, CodingKey{
        case voteCount = "vote_count"
        case id
        case video
        case voteAverage = "vote_average"
        case title
        case popularity
        case posterPath = "poster_path"
        case genreIDs = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult
        case overview
        case releaseDate = "release_date"
    }
}
