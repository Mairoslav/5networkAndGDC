//
//  TMDBClient.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

class TMDBClient {
    
    static let apiKey = "YOUR_TMDB_API_KEY" // 5. Movie Manager Tour, // 01:09 First, we have a static property for the API key. I have a placeholder here, but you should replace it with your API key that you created in previous step.
    
    // 5. Movie Manager Tour, // 01:16 We also have this structure called Auth, short for authentication, define inside the TMDBClients Class. There is a property for the account ID as well as String properties for request token and session ID. IF you do not know what these are at this point that's OK. We will hear from Travis again shortly to discull authenticatio in more detail. Remember these properties are static. So you reference them by class or struct name followed by a period, followed by the name of the static property that do no belong to any instance of the TMDBClints class e.g. "Auth.accountId".
    
    struct Auth {
        static var accountId = 0
        static var requestToken = ""
        static var sessionId = ""
    }
    
    // 5. Movie Manager Tour, // 01:54 In order to make requests to this API, we need endpoints. Here we have an enum called endpoints and a single case to getWatchlist. Endpoints are contructed from the base URL and associated value* down here generates the full path.
    enum Endpoints {
        static let base = "https://api.themoviedb.org/3"
        static let apiKeyParam = "?api_key=\(TMDBClient.apiKey)"
        
        case getWatchlist
        // associated value*
        var stringValue: String {
            switch self {
            case .getWatchlist: return Endpoints.base + "/account/\(Auth.accountId)/watchlist/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
            }
        }
        // 5. Movie Manager Tour, // 02:10 This URL property converts the String value into a URL. THis is just like how we built our endpoints in the RanDog App.
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    // 5. Movie Manager Tour, // 02:19 Down here, we have a method to return the watch-list. It takes a single parameter, completion handler and goes through the steps to create an HTTP get request*, parse the JSON*, and its call to completion handler*. Again this is exaclty like the code we use to make the request in the RanDog APp except we're caling endpoint for the movie database.
    // 5. Movie Manager Tour, // 02:40 THe type passed into the completion handler is an Array of type Movie and the JSON is parsed into a type called MovieResults. Let's take a closer look at these. MovieResults is a Codable struct with a few properties as well as a CodingKeys enum (see/switch to MovieResuts.swift file). Important to know is this "results" property which is an Array of Movie(s). Movie is another struct that conforms to the Codable protocol (see/switch to Movie.swift file)...
    class func getWatchlist(completion: @escaping ([Movie], Error?) -> Void) {
        // HTTP get request*
        let task = URLSession.shared.dataTask(with: Endpoints.getWatchlist.url) { data, response, error in
            guard let data = data else {
                completion([], error)
                return
            }
            // parse the JSON*
            // call to completion handler* three times, check Ctrl + Command + E
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
