//
//  TMDBClient.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// MARK: 3. Improving the Networking Architecture
// MARK: 4. Refactoring: taskForGETRequest

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
        case webAuth
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
                case .logout:
                    return Endpoints.base + "/authentication/session" + Endpoints.apiKeyParam
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    // 00:00 Let's start by refactoring the code for making GETRequests. To do this I am going to add a new class function to "TMDBClient.swift". This is going to be named "taskForGETRequest" as described in the previous vide/lesson.
    // 00:15 Will take a url as a parameter, and it also has a ***generic parameter*** for that "ResponseType" that we parse into. Added between angle brackets. Whatever is passed in is the response type, it just needs to conform to Decodable. So I'll add a protocol conformance after the colon.
    // 00:34 We will also have to add our parameter for the response, which is the response type that gets passed in, so its type will be ResponseType.Type
    // 00:53 THe last argument passed into this function is going to be completion handler. It's an escaping closure, that passes back an instance of ResponseType? or an Error?. Both are optonal since we either successfuly parse the JSON or an error will have occurred.
    // 00:57 Now that we have the parameters set, there's really nothing special about what is going on in this method. In fact we simply modify the code we wrote for our existing requests.
    // 01:06 Here * I've inserted the code we currently use for getting watchlist
    // 01:11 For URL **, instead of getting it directly from the endpoints enum, I am going to pass in the URL you received as parameter,
    // 01:18 and instead of being explicit about the type we decode into, I am going to just decode into ResponseType.self ***
    // 01:26 We'll pass back the responseObject **** if the parsing is successful (deleted ".results" after "responseObject") or if an error occurs when we make the request.
    // 01:35 These are the only changes that are needed and our "taskForGETRequest" is ready to be used. Let's call it in the existing functions for all "GET" requests.
    // 01:43 Down here in "getWatchlist"...
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in // *, **
            guard let data = data else {
                DispatchQueue.main.async { // @@
                    completion(nil, error) // *****
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data) // ***
                DispatchQueue.main.async { // @@@
                    completion(responseObject, nil) // ****
                }
            } catch {
                DispatchQueue.main.async { // @@@@
                    completion(nil, error) // ***** have to be the same as above after guard let ...
                }
            }
        }
        task.resume()
    }
    
    // 01:43 Down here in "getWatchlist", I'll call "taskForGETRequest" func *, parsing in the URL for watchlist. The response type will be MovieResults.self. For the completion handler, I'll just call the parse JSON response - response and the error will be called error
    
    class func getWatchlist(completion: @escaping ([Movie], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getWatchlist.url, response: MovieResults.self) { (response, error) in
            // 02:04 At this point there are only two cases to handle: success and failure. Let's use optional binding to see if the request was successful. That is if the JSON was parsed successfuly. If so we can call the completion handler, passing back your array of movies from our response and it's nil for the error.
            if let response = response {
                completion(response.results, error)
            } else {
                // 02:25 If not, we can just call the completion handler with an empty array like we did before along the error.
                completion([], error)
            }
        } // *
        /*
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
        task.resume() */
    }
    
    // 02:30 Calling "taskForGETRequest" in "getRequestToken" is almost the same. The only difference is that we are also sending the requestToken ** if the request was successful. And completion handler passes back a boolean ***.
    // 02:43 At this point we have the same functionality as before and we can simply remove our old code - see code commented out by /* ...code... */. Our code for making "GET" requests has now been re-factored into the new "taskForGETRequest" method.
    // 02:55 While we are re-factoring, let's also get those calls to async out of the View Controller. We now will be interacting with the UI when completion handler is executed. To keep our calls to async at minimum, I'll jump to the main thread whenever "taskForGETRequest" completion handler gets called.
    // 03:13 This happens if there is an error with a request @@, and if the JSON request succeeds @@@ or fails @@@@
    // 03:20 Then in "LoginViewController.swift" I can remove the call to async ... 
    
    class func getRequestToken(completion: @escaping (Bool, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getRequestToken.url, response: RequestTokenResponse.self) { (response, error) in
            if let response = response {
                Auth.requestToken = response.requestToken // **
                completion(true, nil) // ***
            } else {
                completion(false, error) // ***
            }
        } /*
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
        task.resume() */
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.login.url) // 6. The URL (YES DIFFERENT)
        request.httpMethod = "POST" // 5. The "httpMethod" (NO, THE SAME)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // 4. The "Content-Type" header (NO, THE SAME)
        let body = LoginRequest(username: username, password: password, requestToken: Auth.requestToken) // 2. THe "httpBody" (YES DIFFERENT)
        request.httpBody = try! JSONEncoder().encode(body)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(false, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(RequestTokenResponse.self, from: data) // 3. The response type (passed into "decode()") (YES DIFFERENT)
                Auth.requestToken = responseObject.requestToken // 1. The value saved in the "Auth" struct (YES DIFFERENT)
                completion(true, nil)
            } catch {
                completion(false, error)
            }
        }
        task.resume()
    }
    
    class func createSessionId(completion: @escaping(Bool, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.createSessionId.url)
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
    
    class func logout(completion: @escaping () -> Void) {
        var request = URLRequest(url: Endpoints.logout.url)
        request.httpMethod = "DELETE"
        let body = LogoutRequest(sessionId: Auth.sessionId)
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            Auth.requestToken = ""
            Auth.sessionId = ""
            completion()
        }
        task.resume()
    }
}


