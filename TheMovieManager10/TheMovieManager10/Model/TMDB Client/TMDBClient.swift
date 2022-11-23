//
//  TMDBClient.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// MARK: 7. Feature Search Movies
// TMDBClient.swift / SearchViewController.swift

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
        // 00:53 To make this request, we first need to buld the URL. I add the "search" case here to the endpoint enum
        case search(String) // 01:30 To use an associated value, I'll need to add it to the case name - see above in Endpoints I add (String) after case search. So this is going to be a String.
        
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
                // 00:53 as we'll handle the case in the switch statement,
                case .search(let query):
                    // 01:00 All Movie Database URLs start with the base + which will contacenate with "/search/movie" endpoint + for the parameters, the first one is the "api_key" + and there is another called "query" which is our search String. This value is going to come from a search box and one of the view controllers, so we can't really access it here. However we can use our knowledge of associated values to produce the URL regardless of the serach String.
                    // 01:30 To use an associated value, I'll need to add it to the case name - see above in Endpoints I add (String) after case search. So this is going to be a String.
                    // 01:37 Then in the switch statement we provide a name for the value. Open the parentheses here and just say "let query". you have already see something similar when fetching the image for a specific breed in the RanDog app. F
                    // 01:48 Finally, we'll use String interpolation to pass the query in for our parameter via \(query) after =. This way we will be able to produce a valid search URL for anyu text that user types.
                    // 02:01 To make the request, we'll add yet another method to the TMDBClient class. This one is called search ... see at the bottom ...
                    return Endpoints.base + "/search/movie" + Endpoints.apiKeyParam + "&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")" // 04:59 Back here in the "TMDBClient.swift" let's use presenting codings to generate a valid URL. Swift provides a helpful method called "addingPercentEncoding" to do just that. So, on the query String, I'll call ".addingPercentEncoding" - see it above under switch statement.
                    // 05:11 For allowed characters, there's a lot of options I can choose from, I am going to select ".urlQueryAllowed". If you run the app again, the search URL should be encoded correctly and you can find movies using multiple search keywords. Tapping one of the results, takes you to the DetailView. There is not much going on here yet - blank screen now. We just see the movie's title in the navigation bar. And the buttons down there (watchlist and like) don't actually do anything.
                    // 05:37 So next up, you'll use your knowledge of POST requests, so that users can use these buttons to add movies to the watchlist and fovorites list.

            }
        }
        var url: URL {
            return URL(string: stringValue)! // 03:55 I am not seeing the movie I want here so I'll add another word and wow, what happeded? It says: "Thread 1: Fatal error: Unexpectedly found nil while unwrapping an Optional value". It looks like our URL isn't getting created. When I added a space to type a new word to our search String, we built the URL and the search term was simply added using String interpolation. Unfortunately, URLs cannot contatin spaces. We tried to initialize a URL containing a space but we got nil instead. That doesn't mean we can't search for multiple keywords though. Let's see if the documentation can help.
            // 04:29 Here https://developers.themoviedb.org/3/search/search-movies I click on the "Try it out" sheet, to see how the movie database constructs URLs. I have added the parameter for the query String here (under query line on web it is possible to type in) and note that the query I pass in includes several spaces. Looking at the generaged URL, under the table of the web, take a look at how the query is handled. Instead of spaces, it simply says "%20". If you recall from earlier in the course, we saw these percent encodings produced in the process of generating URLs were not pretty. We can use them to handle special charactersa like spaces.
            // 04:59 Back here in the "TMDBClient.swift" let's use presenting codings to generate a valid URL. Swift provides a helpful method called "addingPercentEncoding" to do just that. So, on the query String, I'll call ".addingPercentEncoding" - see it above under switch statement.
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
    
    // 02:01 To make the request, we'll add yet another method to the TMDBClient class. This one is called search. It takes a query as a parameter as well as the completion handler. Notice that the completion handler takes exactly the same parameters as the "getWatchlist" and "getFavorites" methods, an array of Movies and an optional Error.
    class func search(query: String, completion: @escaping ([Movie], Error?) -> Void) {
        // 02:22 Again we are going to call "taskForGETRequest". The URL will come from the search case of the endpoints enum. And will need to parse the query as the associated value - remember to add .url at the end, and like before we are going to parse it into the MovieResults type with .self at the end.
        // 02:36 And the completion handler looks like the one for the watch list and favorites list, passing back response and an error.
        taskForGETRequest(url: Endpoints.search(query).url, response: MovieResults.self) { (response, error) in
            if let response = response {
                // 02:44 If the parsing was successful, the completion handler is called with an array of movies and is nil for the error.
                completion(response.results, nil)
            } else {
                // 02:50 If not, we can call the completion handler with an empty array and then pass in the error.
                completion([], error)
            }
        }
    }
    // 02:56 The "search" function is going to be called in "SearchViewController.swift" ... transition there ...
}



