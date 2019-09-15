//
//  PopularMovies.swift
//  Movie Collection
//
//  Created by BarisSaglam on 28.07.2019.
//  Copyright © 2019 BarisSaglam. All rights reserved.
//

import Foundation

struct PopularMovies: Codable {
    let status_code: Int?
    let status_message: String?
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [PopularMoviesResult]?
}

extension PopularMovies {
    enum CodingKeys: String, CodingKey {
        case status_code
        case status_message
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
