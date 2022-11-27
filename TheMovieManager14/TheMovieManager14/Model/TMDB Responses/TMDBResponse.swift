//
//  TMDBResponse.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// 02:36 The response is in "TMDBResponse.swift". I call this struct TMBDResponse because responses containing a status code into message are common among request to the movie database. Responses for 400 errors as well as many successful responses are in the same format. We won't be using this struct just for managing the watchlist.

// 02:55 To make this request, we need to add a new method to "TMDBClient.swift" called "markWatchlist" ... move there ...

struct TMDBResponse: Codable {
    
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
