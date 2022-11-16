//
//  TMDBClient.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// MARK: 15. DELETING a Session
// TMDBClient.swift /

class TMDBClient {
    
    // 00:00 Deleting the session should seem quite similar to implementing a post request ... see 00:05 down
    
    static let apiKey = "841622fb8a5a4f75f298f96cb8ba7cd9"
    struct Auth {
        static var accountId = 0
        static var requestToken = ""
        static var sessionId = ""
    }
    
    enum Endpoints {
        
        static let base = "https://api.themoviedb.org/3"
        static let apiKeyParam = "?api_key=\(TMDBClient.apiKey)"
        
        case getWatchlist
        case getRequestToken
        case login
        case createSessionId
        case webAuth
        // TODO: 1.0 add a "logout" case to the "Endpoints" enum
        // 00:29 The 1st step is adding a case to the Endpoints enum.
        case logout
        
        var stringValue: String {
            switch self {
                case .getWatchlist:
                    return Endpoints.base + "/account/\(Auth.accountId)/watchlist/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
                case .getRequestToken:
                    return Endpoints.base + "/authentication/token/new" + Endpoints.apiKeyParam
                case .login:
                    return Endpoints.base + "/authentication/token/validate_with_login" + Endpoints.apiKeyParam
                case .createSessionId:
                    return Endpoints.base + "/authentication/session/new" + Endpoints.apiKeyParam
                case .webAuth :
                    return "https://www.themoviedb.org/authenticate/" + Auth.requestToken + "?redirect_to=themoviemanager:authenticate"
                // TODO: 1.1 and build the correct URL for "stringValue"
                // 00:32 The URL is constructed just like the others starting with the base, followed by the endpoint "/authentication/session" as per https://developers.themoviedb.org/3/authentication/delete-session followed by the query parameter for the API key i.e. Endpoints.apiKeyParam
                case .logout:
                    return Endpoints.base + "/authentication/session" + Endpoints.apiKeyParam
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func getRequestToken(completion: @escaping (Bool, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.getRequestToken.url) {data, response, error in
            guard let data = data else {
                completion(false, error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(RequestTokenResponse.self, from: data)
                Auth.requestToken = responseObject.requestToken
                completion(true, nil)
            } catch {
                completion(false, nil)
            }
        }
        task.resume()
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = LoginRequest(username: username, password: password, requestToken: Auth.requestToken)
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(false, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(RequestTokenResponse.self, from: data)
                Auth.requestToken = responseObject.requestToken
                completion(true, nil)
            } catch {
                completion(false, error)
            }
        }
        task.resume()
    }
    
    class func createSessionId(completion: @escaping(Bool, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.createSessionId.url) // 01:52 change from .login to .createSessionId
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = PostSession(requestToken: Auth.requestToken)
        request.httpBody = try! JSONEncoder().encode(body)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(false, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(SessionResponse.self, from: data)
                Auth.sessionId = responseObject.sessionId
                completion(true, nil)
            } catch {
                completion(false, error)
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
    
    // TODO: 3.0 create method in "TMDBClient.swift" with an appropriate completion handler. The completion handler does not need to pass back any values (unless you choose to handle errors or parse the results).
    // 00:40 And this logout function takes a single parameter, the completion handler "completion:", again nothing is passed back, we just need to alert the calling code when the request is complete.
    // TODO: 4.0 Create a URLRequest using the "logout" case
    // 00:49 The request is just like a post request:  
    class func logout(completion: @escaping () -> Void) {
        // TODO: 5.0 Set the "httpMethod" to "DELETE"
        // providing a request body:
        var request = URLRequest(url: Endpoints.logout.url)
        request.httpMethod = "DELETE" // *** 00:58 the only difference is that the httpMethod is "DELETE"
        // and response body:
        let body = LogoutRequest(sessionId: Auth.sessionId) // create struct in "LogoutRequest.swift"
        request.httpBody = try! JSONEncoder().encode(body)
        // TODO: 5.1 and "Content-Type" to "application/json".
        // setting the "Content-Type" header:
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // 00:05 Here I have implemented a logout functionallity, it's important to know that we do not really care what happens to the sessioId after the user does log out, I do not bother with parsing the result down here, after all you probably haven't seen many error messages about failing to logout. If you implemented it differently that's fine too. We will talk more about error handling in a later session. ... see steps as starting from 00:29
            // TODO: 6.0 Make the request, and call the completion handler where appropriate. Set the "requestToken" and the "sessioId" in the "Auth" struct to an empty String. You do not need to parse the result for this exercise, sinc ethe user will be logged out anyway.
            // 01:01 After making the request, we then need to set the requestToken and sessionId to empty Strings.
            Auth.requestToken = ""
            Auth.sessionId = ""
            // 01:08 Finally we just call the copletion handler.
            completion()
        }
        task.resume()
    }
}

// 01:10 In the extension for UIViewController+Extension.swift ... move there ...

