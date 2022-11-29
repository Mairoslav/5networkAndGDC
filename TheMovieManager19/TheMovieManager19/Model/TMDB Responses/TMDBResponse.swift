//
//  TMDBResponse.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

struct TMDBResponse: Codable {
    
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

// MARK: recap 2. Conform to LocalizedError - we then made TMDBResponse conform to the error protocol, more specifically localizedError, to provide a human-readable error message.
// 02:40 Here I've extended TMDBResponse. Now it conforms to localized error. Localized error just means we can provide an error message that's more readable, and can even be language-specific. As part of conforming to this protocol, you need to provide an error description.

extension TMDBResponse: LocalizedError {
    var errorDescription: String? {
        // MARK: recap 3. Set errorDescription - we set the error description to be the statusMessage from the movie database. Below we replaced "statusMessage" from the movie database with text "Seems like Email or Password are wrong". 
        // 02:56 Here, we'll just return the status message. This is where the API will tell us whether or not our API queue is invalid, login credentials are incorrect, or whichever other error occurred. // 03:08 Now the TMDBResponse conforms to localized error and therefore the error protocol, we can simply pass it in as the error to our completion handler. Back in "TMDBClient.swift" ... move there ...
        return statusMessage // alert appears with bold "OooNo, Login Failed" under which is text: "Invalid API key: You must be granted a valid key" as per Responses from https://developers.themoviedb.org/3/authentication/validate-request-token
        // return "Seems like Email or Password are wrong, try again" // the same allert mesage appears, just changed the text under the bolt text, that one is defined in "LoginViewController.swift" under "showLoginFailure" method together with "OuKey".
    }
}

