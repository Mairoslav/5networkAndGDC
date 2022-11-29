//
//  TMDBClient.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// MARK: 7. Code Review: Handling Errors
// TMDBClient.swift / TMDBResponse.swift / LoginViewController.swift

class TMDBClient {

    // 04:15 Now before we run it, notice how I've changed our API key to just an empty String - previous commented out*. This is to force an error to occur.
    // 04:22 With an invalid apiKey, our request to the movie database should be rejected which will return an error. Let's see what happens. After typing login (having insterted wrong passwor or username), awesome, we get an alert. Well, a lot of the logic hre is specific to the Movie Manager. Using your own custom objects to handle errors will really come in handy as you build your own apps. Let's recap what we did to implement error handling... check recap in bolt comments.
    // 05:18 This is a great start to handling errors in TheMovieManager app. But now we're only handling errors for GET Requests. To better understand how the errors are handled, see if you can implement the same behaviour in "taskForPOSTRequest". Then in completion handlers for logging in and creating the sessionId, display an alert with the localized description as the error message. Done in "TheMovieManager19.xcodeproj".
    // static let apiKey = "841622fb8a5a4f75f298f96cb8ba7cd9" // commented out* (Question2: however when commented out, user cannot log in neither via correct name and pasword).
    static let apiKey = ""
    
    struct Auth {
        static var accountId = 0
        static var requestToken = ""
        static var sessionId = ""
        static var success = true
    }
    
    enum Endpoints {
        
        static let base = "https://api.themoviedb.org/3"
        static let apiKeyParam = "?api_key=\(TMDBClient.apiKey)"
        static let baseImages = "https://image.tmdb.org/t/p/w500"
        
        case getWatchlist
        case getFavorites
        case getRequestToken
        case login
        case createSessionId
        case webAuth
        case logout
        case search(String)
        case markWatchlist
        case markFavorite
        case posterImage(String)
        
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
                case .markWatchlist:
                    return Endpoints.base + "/account/\(Auth.accountId)/watchlist" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
                case .markFavorite:
                    return Endpoints.base + "/account/\(Auth.accountId)/favorite" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
                case .posterImage(let posterPath):
                    return Endpoints.baseImages + posterPath
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }

    // MARK: video2 - Handling Errors
    // 00:00 So why can't TheMovieManager differentiate between errors? We are passing back errors to the view controller, right? We are passing back errors to the view controller, right? Well technically this works. But we are losing information about errors in the process, information that would benefit end-users.
    // 00:17 Let's see how errors are handled currently in "taskForGETReqeust".
    @discardableResult class func taskForGETRequest<ResponseType: Decodable>(url: URL, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask {
        // 00:21 When we call dataTask(with:url), the completion handler gives us some data, a response code and an error. The error can occur when something goes wrong. For example we couldn't connect to the server. In that case, data is nil and we pass back an error in the completion handler. However, if an error specific to the movie database occurs, for example the username and password is incorrect, then data is still returned.
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
                    // 00:49 As far as dataTask is concerned, the request was successful, and so the error is nil.
                    completion(responseObject, nil)
                }
            } catch {
                // 00:55 Now, if something did go wrong, the response may not be in the same format and our parsing code (as defined above "try decoder.decode(ResponseType...") would fail. So we'd get to the catch block by passing back the error to the view controller.
                // 01:08 Behind the scenes, Swift actually just creates an error object here. This is not the same error returned by URLSession. So the only information we pass back to the view controller is that a JSON parsing error occured. That's the point. We do not know however what the specific error message may have been.
                // 01:26 The actual error format used by the movie database can be found on the documentation here https://developers.themoviedb.org/3/authentication/validate-request-token We can scroll down to the different responses. And here is the 401 response for invalid API keys. This returns a status code and a status message. These are the exact same properties as our TMDB response struct in the Movie Manager.
                // 01:44 To capture the error contained in the status message, we just need to add another parsing step. So if we go back into "taskForGETRequest", we can create another" do-and-catch"in the catch block for the 1st parsing step here.
                    do {
                        // MARK: recap 1. Parse the error response (TMDBResponse) - we saw that because our parsing code was not handling movie database specific errors, we could parse the response into a TMDBResponse object to get the status message.
                        // 02:01 THen we're going to parse the JSON again into a constant called errorResponse. This time, when we call decoder.decode, we are going to pass in TMDBResponse.self as the type to parse into. And the data is still the data returned from the Movie Database.
                        // 02:17 Like before because this call can throw, we also need to mark it with try
                        // 02:22 So assuming the parsing was successful, we now have an error message. But what we actually need to pass back to the login view controller is an error object. Remember that error is a protocol that lets our own types provide information about an error. And since the TMDBResponse is used to represent error messages, we can make it conform to the error protocol. // 02:40 Here I've extended TMDBResponse ... move to "TMDBResponse.swift" ...
                        let errorResponse = try decoder.decode(TMDBResponse.self, from: data)
                        // 03:08 Now the TMDBResponse conforms to localized error and therefore the error protocol, we can simply pass it in as the error to our completion handler. Now back from "TMDBResponse.swift" here in "TMDBClient.swift" we'll do that if our parsing step was successful.
                        // 03:29 Like any other calls to the completion handler, we also need to make sure this is called on the main thread. So we'll need to wrap it in a call to async.
                        // 03:36 Great, so now we have an error with a localized description passed back to our view controller. Let's use it to update the UI. Here in the "LoginViewController.swift" ... move there ...
                        DispatchQueue.main.async {
                            completion(nil, errorResponse)
                        }
                    } catch {
                        // 03:23 In case something dows go wrong, we're still passing back the JSON parsing error in our catch block.
                        DispatchQueue.main.async {
                            completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        return task
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
    
    class func search(query: String, completion: @escaping ([Movie], Error?) -> Void) -> URLSessionTask {
        let task = taskForGETRequest(url: Endpoints.search(query).url, response: MovieResults.self) { (response, error) in // **
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
        return task
    }
    
    class func markWatchlist(movieId: Int, watchlist: Bool, completion: @escaping (Bool, Error?) -> Void) {
        let body = MarkWatchlist(mediaType: "movie", mediaId: movieId, watchlist: watchlist)
        taskForPOSTRequest(url: Endpoints.markWatchlist.url, responseType: TMDBResponse.self, body: body) { (response, error) in
            if let response = response {
                completion(response.statusCode == 1 || response.statusCode == 12 || response.statusCode == 13, nil)
            } else {
                completion(false, error)
            }
        }
    }

    class func markFavorite(movieId: Int, favorite: Bool, completion: @escaping (Bool, Error?) -> Void) {
        let body = MarkFavorite(mediaType: "movie", mediaId: movieId, favorite: favorite)
        taskForPOSTRequest(url: Endpoints.markFavorite.url, responseType: TMDBResponse.self, body: body) { (response, error) in
            if let response = response {
                completion(response.statusCode == 1 || response.statusCode == 12 || response.statusCode == 13, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func downloadPosterImage(path: String, completion: @escaping (Data?, Error?) -> Void ) {
        let task = URLSession.shared.dataTask(with: Endpoints.posterImage(path).url) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    task.resume()
    }
                                        
}



