//
//  MarkWatchlist.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// 02:18 The request body, is in "MarkWatchlist.swift".
// 02:23 The "mediaType" is whether or not we're adding a movie or TV show.
// 02:27 THe "mediaId" is a unique identifier for the movie,
// 02:30 And the "watchlist" property tells us whether of not a movie is being added or remeved from the watchlist.

struct MarkWatchlist: Codable {
    let mediaType: String
    let mediaId: Int
    let watchlist: Bool
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaId = "media_id"
        case watchlist = "watchlist"
    }
}

// 02:36 The response is in "TMDBResponse.swift"... move there ...

