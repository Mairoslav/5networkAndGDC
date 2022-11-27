//
//  MarkFavorite.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// MARK: 2. Create a struct for the request body. You can add it to "MarkFavorite.swift" file.
// 00:40 The request body for this method is in "MarkFavorite.swift" file. It takes the same values as "MarkWatchlist" except that instead of "watchlist", the Boolean flag is called "favorite". This subtlety (detail) means that we needed to create the separate struct to make the reqeust body. 00:55 THe response however is in the same format.

struct MarkFavorite: Codable {
    
    let mediaType: String
    let mediaId: Int
    let favorite: Bool
    
    enum CodingKeys: String, CodingKey {
        
        case mediaType = "media_type"
        case mediaId = "media_id"
        case favorite
        
    }
}

// 00:55 THe response however is in the same format. So you can just use the "TMDBResponse" struct that we created in the previous video, to determine if the request was successful. 01:09 The code for marking favorite in "TMDBClient.swift" ... move there ... 


