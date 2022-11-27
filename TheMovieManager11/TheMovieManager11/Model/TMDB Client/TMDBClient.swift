//
//  TMDBClient.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// MARK: 9. Add to Watchlist
// TMDBClient.swift / MarkWatchlist.swift / TMDBResponse.swift / MovieDetailViewController.swift

// MARK: 10. Feature Add to Favorites
// TMDBClient.swift / MarkFavorite.swift / TMDBResponse.swift / MovieDetailViewController.swift

class TMDBClient {

    static let apiKey = "841622fb8a5a4f75f298f96cb8ba7cd9"
    struct Auth {
        static var accountId = 0
        static var requestToken = ""
        static var sessionId = ""
        static var success = true
    }
    
    enum Endpoints {
        
        static let base = "https://api.themoviedb.org/3"
        static let apiKeyParam = "?api_key=\(TMDBClient.apiKey)"
        
        case getWatchlist
        case getFavorites
        case getRequestToken
        case login
        case createSessionId
        case webAuth
        case logout
        case search(String)
        // 01:54 The 1st step is to add the endpoints to the enum, a case called "markWatchlist"
        case markWatchlist
        // MARK: 1. Add the appropriate endpoint to the "Endpoints" enum
        // 00:00 The code for adding and removing movie from the favorites list is nearly the same as managing the watchlist. Implementing this feature provide another opportunity to make a POST reqeust in our app and to see how our "taskForPOSTReqeust" method makes it much easier to add a new requests. Notice the similarities with adding and removing from the watchlist. The endpoint is called "markFovorite". 00:27 And we buil it ...
        case markFavorite
        
        var stringValue: String {
            switch self {
                case .getWatchlist:
                    return Endpoints.base + "/account/\(Auth.accountId)/watchlist/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
                case .getFavorites:
                    return Endpoints.base + "/account/\(Auth.accountId)/favorite/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
                case .getRequestToken:
                    return Endpoints.base + "/authentication/token/new" + Endpoints.apiKeyParam
                case .login:
                    return Endpoints.base + "/authentication/token/validate_with_login" + Endpoints.apiKeyParam
                case .createSessionId:
                    return Endpoints.base + "/authentication/session/new" + Endpoints.apiKeyParam
                case .webAuth :
                    return "https://www.themoviedb.org/authenticate/" + Auth.requestToken + "?redirect_to=themoviemanager:authenticate"
                case .logout:
                    return Endpoints.base + "/authentication/session" + Endpoints.apiKeyParam
                case .search(let query):
                    return Endpoints.base + "/search/movie" + Endpoints.apiKeyParam + "&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
                // 01:57 and again, we handle it in the switch statements. We can concatenate the base URL + with the method name. I just pass in the "accountId" we already have in the Auth struct, so instead of ""account_id" I write "Auth.accountId". Remember that this is just ignored by the movie database.
                // 02:14 we also need to send the API key along with the request so + "Endpoints.apiKeyParam"
                // as per Q&A "Can you advice how can I make the watchlist button within detail view work properly?", added also "&session_id=\(Auth.sessionId)" because the session id is a required field when looking at the API documents, can see under "Query String". 
                // 02:18 The request body, is in "MarkWatchlist.swift" ... transition there ...
                case .markWatchlist:
                    return Endpoints.base + "/account/\(Auth.accountId)/watchlist" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
                // MARK: 1.1 handle it in swith statement
                // 00:27 And we build it from the URL just like we do with other requests, starting with the base URL + the endpoint for the documentation + and then adding parameters for the API key + and the session ID (can see in documentation under "Query String" that both parameters are required: api_key and also session_id. The request body for this method is in "MarkFavorite.swift" file ... move there ...
                case .markFavorite:
                    return Endpoints.base + "/account/\(Auth.accountId)/favorite" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(responseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    class func getWatchlist(completion: @escaping ([Movie], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getWatchlist.url, response: MovieResults.self) { (response, error) in
            if let response = response {
                completion(response.results, error)
            } else {
                completion([], error)
            }
        }
    }
    
    class func getFavorites(completion: @escaping ([Movie], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getFavorites.url, response: MovieResults.self) { (response, error) in
            if let response = response {
                completion(response.results, error)
            } else {
                completion([], error)
            }
        }
    }
    
    class func getRequestToken(completion: @escaping (Bool, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getRequestToken.url, response: RequestTokenResponse.self) { (response, error) in
            if let response = response {
                Auth.requestToken = response.requestToken
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = LoginRequest(username: username, password: password, requestToken: Auth.requestToken) // *
        taskForPOSTRequest(url: Endpoints.login.url, responseType: RequestTokenResponse.self, body: body) { (response, error) in
            if let response = response {
                Auth.requestToken = response.requestToken // **
                completion(true, nil) // ***
            } else {
                completion(false, nil)
            }
        }
    }
    
    class func createSessionId(completion: @escaping(Bool, Error?) -> Void) {
        let body = PostSession(requestToken: Auth.requestToken)
        taskForPOSTRequest(url: Endpoints.createSessionId.url, responseType: SessionResponse.self, body: body) { (response, error) in
            if let response = response {
                Auth.sessionId = response.sessionId // *
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func taskForDELETERequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(responseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
     
    class func logout(completion: @escaping () -> Void) {
        let body = LogoutRequest(sessionId: Auth.sessionId)
        taskForDELETERequest(url: Endpoints.logout.url, responseType: LogoutResponse.self, body: body) { (response, error) in
            if let response = response {
                Auth.success = response.success 
                completion()
            }
        }
    }
    
    class func search(query: String, completion: @escaping ([Movie], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.search(query).url, response: MovieResults.self) { (response, error) in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    // 02:55 To make this request, we need to add a new method to "TMDBClient.swift" called "markWatchlist". We need to tell TMDBClient which movie to mark on the watchlist, based on the ID. So we'll take a "movieId" parameter, which is an Integer, and it will also need a Boolean. True if we are adding a movie and false if we are removing a movie. The completion handler looks just like the others we've seen. Passing back a Boolean which is true if the request was successful, and an optional error if case the request fails.
    class func markWatchlist(movieId: Int, watchlist: Bool, completion: @escaping (Bool, Error?) -> Void) {
        // 03:27 The request body is "MarkWatchlist" struct. The "mediaType" is "movie", the "mediaId" is just the "movieId" we passed in, and we also pass in the "Boolean" for watchlist so see whether we are adding or removing a movie
        let body = MarkWatchlist(mediaType: "movie", mediaId: movieId, watchlist: watchlist)
        // 03:40 We then call "taskForPOSTRequest". The URL is the "markWatchlist" from the Endpoints enum. For the response type we'll parste in the generic "TMDBResponse" struct we just created. For body will pass in body. And the completion handler will either return a response of type response type or an optional error (then why not ?).
        taskForPOSTRequest(url: Endpoints.markWatchlist.url, responseType: TMDBResponse.self, body: body) { (response, error) in
            // 04:02 We'll use optional binding to check the response.
            if let response = response {
                // 04:05 Remember that the status code can tell us whether or not the request was successful by returning either status codes 1, 12 or 13. So in the completion handler, we'll check if status code equals either one of these status codes, using the OR operator. This will evaluate it to either true or false. We pass in nil for the error if our parsing succeeds.
                completion(response.statusCode == 1 || response.statusCode == 12 || response.statusCode == 13, nil)
            } else {
                // 04:25 We know if there is no response data, we can just call the completion handler by passing in false, for whether or not the request was successful, along with the error.
                completion(false, error)
            }
        }
    }
    // 04:36 We'll call this one ("func markWatchlist") on the "@IBAction func watchlistButtonTapped" in the "MovieDetailViewController.swift". ... move there ...
    
    // MARK: 3. Create "markFavorite" method in "TMDBClient" that takes the movieId as a parameter, a Boolean flag, and an appropriate completion handler.
    // 01:09 The code for marking favorite in "TMDBClient.swift" is just like the code for adding and removing from the watchlist. We just used a "MarkFavorite" struct as the request body and then pass in the appropriate endpoints when we call "taskForPOSTReqeust".
    class func markFavorite(movieId: Int, favorite: Bool, completion: @escaping (Bool, Error?) -> Void) {
        let body = MarkFavorite(mediaType: "movie", mediaId: movieId, favorite: favorite)
        // MARK: 4. Make the reqeuest using "taskForPOSTRequest and call "markFavorite"'s completion handlder appropriately.
        // 01:10 and then pass in the appropriate endpoints when we call "taskForPOSTReqeust". Everything else including how we handled the status codes is the same. 01:19 In the "MovieDetailViewController.swift" ... move there ...
        // For step 5 move to "MovieDetailViewController.swift" ...
        taskForPOSTRequest(url: Endpoints.markFavorite.url, responseType: TMDBResponse.self, body: body) { (response, error) in
            if let response = response {
                completion(response.statusCode == 1 || response.statusCode == 12 || response.statusCode == 13, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
}



