//
//  PostSession.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// TODO: 3. Create a "Codable" struct for the request body in "PostSession.swift" with an appropriate "CodingKeys" enum. For step 4 move to "SessionResponse.swift".

struct PostSession: Codable {
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case requestToken = "request_token"
    }
}
