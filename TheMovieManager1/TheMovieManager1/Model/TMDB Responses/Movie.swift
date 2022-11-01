//
//  Movie.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// 5. Movie Manager Tour, // 02:40 ... Movie is another struct that conforms to the Codable protocol (see/switch to Movie.swift file). THere were a lot of properties as well as a CodingKeys enum for each one. Its not important to know each of these properties, but I ahve linked the documentation below so that you can see how the Movie Results struct and the nested Array of Movies reflects the JSON responses structure.
// 5. Movie Manager Tour, // 03:22 We store our app data in MovieModel.swift file, move there...
struct Movie: Codable, Equatable {
    
    let posterPath: String?
    let adult: Bool
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    let id: Int
    let originalTitle: String
    let originalLanguage: String
    let title: String
    let backdropPath: String?
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let voteAverage: Double
    
    var releaseYear: String {
        return String(releaseDate.prefix(4))
    }
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
}
