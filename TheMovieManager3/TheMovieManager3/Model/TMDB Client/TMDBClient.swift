//
//  TMDBClient.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// TODO: 7. GET The Request Token - video 1 & 2 (here only the main points left within comments)
// ..... 9. Login with Email And Password
// TMBDClient / LoginRequest.swift / LoginViewController.swift / ...

class TMDBClient {
    
    static let apiKey = "841622fb8a5a4f75f298f96cb8ba7cd9"
    struct Auth {
        static var accountId = 0
        static var requestToken = ""
        static var sessionId = ""
    }
    
    // 00:00 With our knowledge of making POST requests, let's implement step two of the authentication flow. First things first, we need a new Endpoint.
    enum Endpoints {
        
        static let base = "https://api.themoviedb.org/3"
        static let apiKeyParam = "?api_key=\(TMDBClient.apiKey)"
        
        case getWatchlist
        case getRequestToken // MARK: 1. TODO:  Add a new case to the endpoints enum called "getRequestToken"
        // 00:10 So, add a case to the enum which I'll call login, and will handle the login case down in the switch stamentement.
        case login
        
        var stringValue: String {
            switch self {
                case .getWatchlist:
                    return Endpoints.base + "/account/\(Auth.accountId)/watchlist/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
                case .getRequestToken:
                    return Endpoints.base + "/authentication/token/new" + Endpoints.apiKeyParam // MARK: 2. TODO: Add a case to the "switch" statement for "stringValue". Build the URL from the base URL, the Endpoint, and the API key query parameter.
                case .login:
                    return Endpoints.base + "/authentication/token/validate_with_login" + Endpoints.apiKeyParam //   00:18 The URL is built from the base, the endpoint, and the query parameter for the API key. There are no othere query parameters. So we are all set.
                    // 00:27 Looking at the response body in the documentation, we can see that we receive a JSON object with three key-value pairs: success, expires_at, and request_token. Look back at the RequestTokenResponse.swift in TheMovieManager, and you'll see that these properties are the same as the struct we created in the 1st step (i.e. within / TODO: 7. GET The Request Token)
                    // 00:49 So, we will not need to create another struct for this step, instead we can use the one we have already defined. However because this is a POST request, we also need to Encode a JSON object to be sent along with the request.
                    // 01:03 Here on https://developers.themoviedb.org/3/authentication/validate-request-token under "Request Body" it looks like there's three String properties: username or the email address, password, and request_token - which is the request token we got printed out in console in previous step.
                    // 01:13 Let's add a struct to medel the request body in TheMovieManager. Here in "LoginRequest.swift" ... move there
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    // MARK: 4. TODO Add a "class func" to "TMDBClint" to get the request token. use the "getRequestToken" case as the URL. The completion handler should pass back two values, a "Bool", and an "Error?". Pass in "true" if parsing (getting the request token succeeds), otherwise pass in "false". Use the "getWatchlist" method as a guide.
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
    
    // 01:38 Let's make this request back in the TMDBClient.swift. Like before, I'll add a new class method, call it login() and it will take an @escaping closure as the completion handler.
    // 01:51 The first value will be a Boolean for whether or not that login was successful. The second value will be an optional error.
    // 01:59 This is once again just like our GET request, except that we are also sending data to the server.
    // 02:07 The user types their username or email and their password on the login screen. So, we also need to parse in these as parameters when this method is called.
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        // 02:15 To implement this method, the steps will be a bit different from a GET request. Instead of simply parsing the URL into the dataTask method, we first need to create a URLRequest for the URL, passing in the login endpoint we just created. Note that I mark this as var instead of let, URLRequest is a struct, not a class. So if you want to change any of these values, like we're about to do, we need to make it a var rather than let.
        var request = URLRequest(url: Endpoints.login.url)
        // 02:44 By default, URLRequests are GET requests. But we are making a POST request. So our next step is to set the httpMethod to POST.
        request.httpMethod = "POST"
        // 02:53 We need to tell the server that our data is in the JSON format. To do this, I'll call addValue and to pass in "application/json", along with "Content-Type" for forHTTPHeaderField.
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // 03:06 Now to set the request body, we know that it will be an instance of our LoginRequest struct, which needs three values: a username, a password, and a requestToken. The username and password are passed in as parameters to this function. And the requestToken was tored in the Auth struct in the previous step.
        let body = LoginRequest(username: username, password: password, requestToken: Auth.requestToken)
        // 03:29 LoginRequest conforms to Encodable, so we set the httpBody by creating a JSONEncoder and encode the object. We know thatf this encoding will be successfull and that our JSON is valid so I'am just going to disable error propagation with try!
        request.httpBody = try! JSONEncoder().encode(body)
        // 03:47 Great, so we are all set up to make a POST request. Like before, we call URLSession.shared.dataTask, which also accepts a URLRequest as a parameter. So we pass in our request and then use trailing closure syntax for the completion handler, which passed back data, response, and error.
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // 04:10 At this point we handle the response just as we would with a GET request. I make sure that this data is not nil using a guard. If it is, I'll pass false into the completion handler along with the error.
            guard let data = data else {
                completion(false, error)
                // 04:19 And will exit the closure early with return
                return
            }
            // 04:22 Then we need to parse the response using a do catch
            do {
                // 04:25 In the do block, I'll create a JSONDecoder, and will parse it into a responseObject by calling decoder.decode and passing in the RequestTokenResponse.self as the type, as well as the data we are trying to decode. And remember to mark this as try when we're decoding JSON.
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(RequestTokenResponse.self, from: data)
                // 04:49 Once we have parsed the response, we should have a new reqeustToken that's been validated by the user. So, we'll update the ones stored in the Auth struct,
                Auth.requestToken = responseObject.requestToken
                // and call the completion handler passing in true and nil for the error.
                completion(true, nil)
            } catch {
                // 05:02 If the parsing fails, we'll pass in false along with an error like before.
                completion(false, error)
                // 05:08 Finally, like with any network request, we need to get a reference to the task (therefore adding let task = ... above) that's returned by the dataTask method and then call task.resume() so that we know it will be executed. See below.
            }
        }
        task.resume()
        // 05:22 That's a lot of code but it's nearly identical to what we have already written for the GET reqeust. We just have a few extra steps to make the request. Back in "LoginViewController.swift", ...
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

