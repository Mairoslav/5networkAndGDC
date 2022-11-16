//
//  TMDBClient.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// MARK: 5. Finish Refactoring taskForPOSTRequest
// TMDBClient.swift / LoginViewController.swift / UIViewController+Extension.swift

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
    
    // TODO: 1. Create the "taskForPOSTRequest" method to extract the code for making "POST" requests. *** Note the addition of the "RequestType" generic and the "body" of type "RequestType".
    // 00:20 Two generic types, ResponseType as we had before is Decodable, and that's because just like a GET request, POST requests are also going to return a JSON response, that we need to parse.
    // 00:35 There is also a new generic type for RequestType, this is going to be sruct that conforms to Encodable (to turn our Swift objects into JSON).
    // 00:50 Like before each POST request has a different Endpoint. So we take the url as the parameter and we also need to specify the type we parse into with the responseType parameter. As well as the body with the body parameter which is of type RequestType. Finally comes the completion handler. Again, we pass back an otptional ResponseType?, along with an Error?.
    // 01:36 Now we can use "taskForPOSTRequest" in each method that needs to make a POST request. In the "login" method ...
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        // 01:22 Inside we simply follow the steps for making a POST request, using the parameters we have passed in.
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // let body = LoginRequest(username: username, password: password, requestToken: Auth.requestToken)
        request.httpBody = try! JSONEncoder().encode(body)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
            // TODO: 6. Move any calls to "DispatchQueue.main.async()" out of the View Controllers. Instead, wrap each call to the completion handler in the async block. That way, you'll never need to skip to the main thread after making one of the requests.
                DispatchQueue.main.async { // 01:27 added async, when error occurs
                    completion(nil, error)
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(responseType.self, from: data)
                DispatchQueue.main.async { // 01:27 added async, and when request is successful, everytime the completion is called
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
    
    // TODO: 2. Modify the "login()" function in "TMDBClient" to call "taskForPOSTRequest". Pass in your instance of the "LoginRequest" struct as the body.
    // 01:36 Now we can use "taskForPOSTRequest" in each method that needs to make a POST request. In the "login" method, we create an instance of the LoginReqeust struct for the request body *.
    
    // TODO: 3. In the completion handler, if the JSON response is not nil, set the "requestToken" in the "Auth" struct and call the completion handler with "true" for "success" and "nil" for the "error".
    // 01:48 And like before we check if we parse the response successfuly. Set the "requestToken" in the "Auth" ** struct and then call the completion handler ***.
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
        /*
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
        */
    }
    
    // TODO: 4. Modify the "createSessionId" function in "TMDBClient.swift" to call "taskFORPostRequest". Pass in your instance of the "PostSession" struct as a parameter.
    // 01:54 The "createSessionId" method works the same way, the only difference being the parameters we pass in.
    
    // TODO: 5. In the completion handler, if the JSON response is not nil, set the "sessionId" in the "Auth" struct and call the completion handler with "true" for "success" and "nil" for the "error".
    // 02:00 In the completion handler, if the request was successful, we set the sessionId *
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
        /*
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
        */
    }
    
    // 02:07 Both of these requests can be iplmeneted with minumum code, all the heavy lifting is done in "taskForPOSTRequest". The other benefit is that we do not need to jump to the main thread each time.
    // 02:16 Notice in the "LoginViewController.swift" we do no longer need any calls to async.
    
    // MARK: Reflect - implement a "taskForDELETERequest" method
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
        taskForDELETERequest(url: Endpoints.logout.url, responseType: RequestTokenResponse.self, body: body) { (response, error) in
            if let response = response {
                Auth.requestToken = response.requestToken
                completion()
            }
        }
        /*
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
        */
    }
}


