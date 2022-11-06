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
        case createSessionId // TODO: 1. Add a "createSessionId" case to the "Endpoints" enum
        
        var stringValue: String {
            switch self {
                case .getWatchlist:
                    return Endpoints.base + "/account/\(Auth.accountId)/watchlist/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
                case .getRequestToken:
                    return Endpoints.base + "/authentication/token/new" + Endpoints.apiKeyParam
                case .login:
                    return Endpoints.base + "/authentication/token/validate_with_login" + Endpoints.apiKeyParam
                case .createSessionId:
                    return Endpoints.base + "/authentication/session/new" + Endpoints.apiKeyParam // TODO: 2. Handle the "createSessionId" case in "switch" statement to build the URL, by concatenating the base URL, the endpoint, and the API key query parameter. For step 3 move to "PostSession.swift"
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
                Auth.requestToken = responseObject.requestToken // MARK: 5. TODO  In your "getRequestToken" method, if the token is successfully created, set "Auth.requestToken" to the request token.
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
    
    // TODO: 5. Add a "class func" in "TMDBClient" to make the request. It should take one parameter, a completion handler (@escaping closure) that passes back a "Bool" and an "Error?".
    // TODO: 6. Implement the steps to make the POST request. The body should be the "PostSession" struct with the "requestToken".
    class func createSessionId(completion: @escaping(Bool, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.createSessionId.url) // 01:52 change from .login to .createSessionId
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = PostSession(requestToken: Auth.requestToken) // 01:55 change from LoginRequest to PostSession struct, passing in the .requestToken, which we get from the Auth struct.
        request.httpBody = try! JSONEncoder().encode(body)
        // Keybord: CTRL + / to the completion handler (String) -> Void and press ENTER. Mouse: Double click on the text (String) -> Void>).
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(false, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                // TODO: 7.1 The result should be parsed into the "SessionResponse" struct created in the previous step.
                let responseObject = try decoder.decode(SessionResponse.self, from: data) // no RequestTokenResponse
                // TODO: 7.2 If the parsing is successful, set the "sessionId" in the "Auth" struct. I.e. instead of Auth.requestToken write Auth.sessionId
                Auth.sessionId = responseObject.sessionId // 01:26 And then instead of updating the "requestToken" after parsing the response, you can just update the "sessionId" in the home struct here
                // 01:05 (video1), 02:14 (video2) Everything else is just going to look like the login* method we have just created. Note difference from previous lesson between methods login and getWatchlist due to URL vs URLRequest.
                // TODO: 8. Call the completion hanlder with the correct values, where appropriate.
                completion(true, nil)
            } catch {
                completion(false, error)
                // TODO: 9. In "LoginViewController.swift" add a "handleSessionResponse" method that takes a "Bool" and an "Error?" as parameters. Move there...
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

