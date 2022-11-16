//
//  TMDBClient.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// MARK: 10. Create Session ID
// TMBDClient / PostSession.swift / SessionResponse.swift / LoginViewController.swift

class TMDBClient {
    
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
        // 00:47 (from "LoginViewController.swift") If success is true, we have a requestToken. To validate it, we open the URL specified by the documentation. For consistency let's go to the "TMDBClient.swift" an dadd a new case to the Endpoints enum ... year we are here. I'll add a new case called webAuth,
        case webAuth
        
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
                // 01:03 and handle it in switch statement, it will return the URL specified in the documentation, with the requestToken added.
                case .webAuth :
                    return "https://www.themoviedb.org/authenticate/" + Auth.requestToken + "?redirect_to=themoviemanager:authenticate"
                // 01:12 This will work, but we also want the browser to return to our app, after the user does authenticates. To do this, we need to specify the redirectURL. Its added as query parameter called "redirect_to" (see above) and since this is the 1st one ~ 1st query, we need to start it with a question mark.
                // 01:30 For the URL, I'll add "themoviemanager:authenticate", the part before the colon is the protocol, in our case the URL to be handled by TheMovieManager. Authenticate after colon, is the path. If we wanted to handle multiple incoming URLs in our app, we could specify a different path.
                // 01:52 Back in the "LoginViewController.swift" ... move there
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
    
}

