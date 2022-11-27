//
//  TMDBClient.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// MARK: 12. Feature: Poster Image on Detail View
// TMDBClient.swift / Movie.swift / MovieDetailViewController.swift

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
        static let baseImages = "https://image.tmdb.org/t/p/w500" // https://developers.themoviedb.org/3/getting-started/images added only now
        
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
        // MARK: 1. Add a case to the "Endpoints" enum for a "posterImage" ...
        // 00:00 To show the image in the detail view, we need to add a method capable of downloading the image data for movie posters. The first step is to build the URL. And for consistency we will do this in the endpoints enum. By adding a new case called posterImage.
        // 00:18 We will also have an associated value which is going to be a String for the poster path. // 00:22 We will build it down here in switch statement and it wil return ...
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
                // MARK: 1. Add a case to the "Endpoints" enum for a "posterImageURL" with a "(String)" associated value. THe URL can be constructed, by concatenating the base https://image.tmdb.org/t/p/w500 + and the "posterPath". The "posterPath" comes from a "Movie" struct and can be passed in via the associated value.
                // 00:22 We will build it down here in switch statement and it wil return full URL which we can copy from the documetnation as String or as done here set it via static let baseImages = "https://image.tmdb.org/t/p/w500" above + concatenate is with the poster path that we pass as the associated value.
                // 00:41 (of video1) In the movie manager app the struct Movie in "Movie.swift" has a property for the poster_path "let posterPath: String?" as we can use this to build the URL for any poster image.
                // 00:34 To make the request ... now move at the bottom of "TMDBClient.swift" ...
                case .posterImage(let posterPath):
                    return Endpoints.baseImages + posterPath
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
    
    // MARK: 2. Create a new "class" method in "TMDBClient" called "downloadPosterImage" for downloading the file. It should take two parameters, a "String" for the "posterPath" and a completion handler that takes two parameter of type "Data?" (the ram image data) and "Error?".
    // 00:34 To make the request, we'll create a new method that downloads an image, taking the poster path as a parameter "path", as well as the completion handler. The completion handler passed back an optional containing an image data, as well as an error. Now while technically we are retrieving data from the network, we can't just call "taskForGETRequest", we're not making a get request and parsing JSON. Downloading the image is actually simpler and something you've already done.
    class func downloadPosterImage(path: String, completion: @escaping (Data?, Error?) -> Void ) {
        // MARK: 3. Make a network request to download the image with the poster path. Either a "dataTask" (like in ranDog app) or a "downloadTask" will work. Be sure to call the completion handler to pass back the "data", and "error". Now move to "
        // 01:03 We just need to call URLSession.shared.dataTask(... , for parameter with we'll pass in the posterImage from our endpoints enum, setting the path as the associated value.
        // 01:11 In the completion handler, we just get back data, response and error. Notice that the values in our completion handler are both optionals, so they can be nil just like the data and error returned by dataTask with url. We don't need to check for nil here (why? because we are sure there is image for each movie on TMDb?), so I'm just going to call the completioin handler, passing in the data dn the error.
        // 01:30 And remember, since we'll be updating the UI on the main thread, we need to wrap this in a call to async().
        let task = URLSession.shared.dataTask(with: Endpoints.posterImage(path).url) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    // 01:38 Finally, we just need to get a reference to the task (see above "let task = ...), so we can then call task.resume(). // 01:45 Now we can make the reqeust to download the image in the "viewDidLoad()" method withing "MovieDatailViewController.swift" ... move there ...
    task.resume()
    }
                                        
}



