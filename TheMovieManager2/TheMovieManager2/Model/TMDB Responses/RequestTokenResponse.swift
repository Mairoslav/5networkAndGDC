//
//  RequestTokenResponse.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// 01:47 In the Movie Manager there is already a file called "RequestTokenResponse.swift" - (move there, yeah here I am), where you can add the struct, and of course keep in mind adding the CodingKeys as well.

// 01:57 Back in IMDBClient.swift (move there) to make the request, the process is very similar to the getWatchlist method...

// MARK: 00:40 We also need to represent the response in our app, so I open up "RequestTokenResponse.swift" ... move there, yeah I am here. And create a new struct of the same name. And the struct will conform to the Codable protocol. You can refer back to the documentation for the exact values contained in this response. There's success - a Boolean, expiresAt - which is a String and its requestToken - which is also a String.

struct RequestTokenResponse: Codable {
    let success: Bool
    let expiresAt: String
    let requestToken: String
    
    // MARK: 01:11 The keys and the responses are slightly different from the names we would use in Swift. So I'll add a CodingKeys enum with the raw-value of String and CodingKey.
    enum CodingKeys: String, CodingKey {
        // MARK: success is the same name as the JSON key. So I'll add it as an empy case,
        case success
        // MARK: and spoke to expireAt and requestToken have underscores in the JSON keys (check documentation at web site). So I address it as per below code:
        case expiresAt = "expires_at"
        case requestToken = "request_token"
        // MARK: 01:31 All of this information needed to create the RequestTokenResponse struct is available in the documentation https://developers.themoviedb.org/3/authentication/create-request-token
        // MARK: 01:39 Now that you have modeled the response, let's go back to the TMDBClient to make the request...move there
    }
}

// MARK: // 3. TODO:  Create a "Codable" struct in "RequestTokenResponse.swift" to model the response with an appropriate "CodingKeys" enum.
