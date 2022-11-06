//
//  TMDBClient.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// ......7. GET The Request Tokenm - video 1
// MARK: 7. GET The Request Tokenm - video 2
// TMBDClient / RequestTokenResponse.swift / LoginViewController.swift

class TMDBClient {
    
    static let apiKey = "841622fb8a5a4f75f298f96cb8ba7cd9"
    struct Auth {
        static var accountId = 0
        static var requestToken = ""
        static var sessionId = ""
    }
    
    enum Endpoints {
        // 01:28 For the URL to create the request token, all you need is to concatenate the base URL, the endpoint, and the parameter for the API key stored in this constant "apiKeyParam". There are no other query parameters we need to add. To model the response you can use a Codable struct.
        // 01:47 In the Movie Manager there is already a file called "RequestTokenResponse.swift" - move there, where you can add the struct, and of course keep in mind adding the CodingKeys as well.
        
        static let base = "https://api.themoviedb.org/3"
        static let apiKeyParam = "?api_key=\(TMDBClient.apiKey)"
        // MARK: How did it go creating the request token? This is the first change we are making to movie manager, so I'll walk you through implementing each step. In order to make a request, the first thing we need is the URL. Tto build it, I'll add a new case to the endpoints enum called "getRequestToken".
        case getWatchlist
        case getRequestToken // MARK: 1. TODO:  Add a new case to the endpoints enum called "getRequestToken"
        var stringValue: String {
            switch self {
            case .getWatchlist: return Endpoints.base + "/account/\(Auth.accountId)/watchlist/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)" // 01:12 Subsequent query parameters are separated by an ampersand "&" such as the URL we used to get the watchlist i.e. "getWatchlist". We first add the "apiKeyparam", and we also specify the "session_id", as said this and further query parameters are separated by an ampersand "&" as can see above "&session_id=\(Auth.sessionId)". The same format would be used for any additional query parameters.
            // MARK: 00:18 And to build the String value, I'll handle this case in the switch statement. Building the URL consist of concatenating three components: 1. the base URL we use for all requests, 2. the Endpoints which I've copied from the documentation, 3. and the API key which comes from this apiKeyParam constant.
            // MARK: 00:40 We also need to represent the response in our app, so I open up "RequestTokenResponse.swift" ... move there
                case .getRequestToken:
                    return Endpoints.base + "/authentication/token/new" + Endpoints.apiKeyParam // MARK: // 2. TODO: Add a case to the "switch" statement for "stringValue". Build the URL from the base URL, the Endpoint, and the API key query parameter.
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    // 01:57 Back in IMDBClient.swift (move there, yeah here I am) to make the request, the process is very similar to the getWatchlist method. The only difference is that instead of passingback an Array of movies like we did here with [Movie], we'll pass back a boolean into the Completion handler. We'll set the value to true if the request token was created, and false if it was not.
    // 02:16 Then you'll simply make the request, and parse the JSON using a JSON decoder, passing back either true or false in the completion handler along with the error if appropriate.
    // 02:27 If the requet was successful, be sure to store the requestToken in the requestToken property of the Auth struct up there. That way we can use it in later requests.
    // 02:35 Finally, we need to call the method to actually get the requestToken. We'll do this in the "LoginViewController.swift", moving there...
    
    // MARK: 01:39 Now that you have modeled the response, let's go back to the TMDBClient to make the request...move there, yeah I am here.
    // MARK: 01:44 I'll add a new class function called "getRequestToken". Just like the other request we have made, it will use an @escaping closure as a completion handler.
    // MARK: 01:55 In brackets after @escaping, the 1st value will be Boolean. True if the requestToken was created successfully and fale if the requestToken fails. The 2nd value will be an optional error. Now I strongly advice against copying and pasting code in practice but I'am going to break my own rule just to show you how this is nearly identical to the other getRequest we have already created within func getWatchlist() - here he does copy code within func getWatchlist starting from  let task = URLSession.shared... up to task.resume(). There are just a few things that need to be changed.
    // MARK: 02:22 The first is that we're making a different request. So I. update the Endpoint to Endpoints.getRequestToken.url, II. and the response type is not MovieResults, instead now it is the RequestTokenResponse struct we have just created. III. And instead of passing in an Array of Movies into the completion handler, we'll just pass in true if the parsing was successful and it will be false in the other cases i.e. in catch body. MOMENT-why nil left in both cases?
    // MARK: 02:46 So why does this work? Looking back at the documentation, we can see the response for 200 status codes in the format of the requestTokenResponse struct we just created. But if you look at some of the failed 400 response codes, you'll see that the format is different. If our request was not successful, we would not be able to parse into the reqeustTokienResponse struct which is why we pass in false in the completion handler.
    // MARK: 4. TODO Add a "class func" to "TMDBClint" to get the request token. use the "getRequestToken" case as the URL. The completion handler should pass back two values, a "Bool", and an "Error?". Pass in "true" if parsing (getting the request token succeeds), otherwise pass in "false". Use the "getWatchlist" method as a guide.
    class func getRequestToken(completion: @escaping (Bool, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.getRequestToken.url) {data, response, error in
            guard let data = data else {
                completion(false, error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(RequestTokenResponse.self, from: data)
                // MARK: 03:14 Here in the TMDBClient.swift, the only thing left to do is save the requestToken if the request is successful.
                // MARK: 03:18 and will do that in the Auth struct, setting the requestToken property to the response objects requestToken. Cool, so we have our new network request. Let's update the LoginViewController.swift to create the requestToken, move there...
                Auth.requestToken = responseObject.requestToken // MARK: 5. TODO  In your "getRequestToken" method, if the token is successfully created, set "Auth.requestToken" to the request token.
                completion(true, nil)
            } catch {
                completion(false, nil)
            }
        }
        task.resume()
    }
    
    class func getWatchlist(completion: @escaping ([Movie], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.getWatchlist.url) { data, response, error in
            guard let data = data else {
                completion([], error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(MovieResults.self, from: data)
                completion(responseObject.results, nil)
            } catch {
                completion([], error)
            }
        }
        task.resume()
    }
    
}

/*
 printed out after just pressing login 1st time
 1739c36906377d67574130ccdb19083d9d27a54e
 
 printed out after just pressing login 2nd time
 edcaa6e54f4012341d486d397603e3d89f768449
 
 printedout after writing in user name and password and pressing login 1st time
 0fce7b99c665e9e18250ee376c6a33c92db33431
 
 */
