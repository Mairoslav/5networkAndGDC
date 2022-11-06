//
//  Login.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// 01:13 Let's add a struct to model the request body in TheMovieManager. Here in "LoginRequest.swift" I've added a struct that conforms to the Codable protocol, and we have properties for the username, password, and requestToken.

struct LoginRequest: Codable {
    let username: String
    let password: String
    let requestToken: String // 01:26 This in the JSON with underscore as request_token, so we need to add a CodingKeys in the enum
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
        case requestToken = "request_token"
    }
}

// 01:38 Let's make this request back in the TMDBClient.swift, move there...
