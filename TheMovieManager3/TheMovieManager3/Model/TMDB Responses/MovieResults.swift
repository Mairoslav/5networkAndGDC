//
//  MovieResults.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

struct MovieResults: Codable {
    
    let page: Int
    // 5. Movie Manager Tour, // 02:40 ... Let's take a closer look at these. MovieResults is a Codable struct with a few properties as well as a CodingKeys enum (see/switch to MovieResuts.swift file). Important to know is this "results" property which is an Array of Movie(s)
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}
