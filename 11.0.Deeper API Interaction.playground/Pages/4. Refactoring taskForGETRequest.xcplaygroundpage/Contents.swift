//: [Previous](@previous)

import Foundation

// MARK: 4. Refactoring: taskForGETRequest

// 00:00 Let's start by refactoring the code for making GETRequests. To do this ... check directly the comments within "TheMovieManager7".

// MARK: text under the video - Refactoring the POST Requests
/*
 We just refactored the GET requests into a new function, taskForGETRequest, which looks like this.
 
 class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void)
 
 When making a GET request, we specify the URL, the "ResponseType", and pass back a "ResponseType?" and an "Error?". Our code for making POST requests is similar. The only difference is that we also provide a JSON body. The new `taskForPOSTRequest would need the following additional information:
 
    - "RequestType": A generic, just like "ResponseType" that specified the type of the JSON body, that must conform to the "Encodable" protocol.
 
    - "body": A "RequestType". This value is encoded and used as the "httpBody".

 *** Thus, the "taskForPOSTRequest" method would look something like this (note the addition of the "RequestType" generic and the "body" of type "RequestType".

 class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void)
 
 Like with GET requests, the logic of making POST requests, passing in the URL, and parsing the JSON should be the same. Once you've implemented "taskForPOSTRequest", call it in the existing functions that make POST requests.
 */

// MARK: QUIZ_QUESTION: Follow the steps to refactor the code for making "POST" request.
// this I am doing in "TheMovieManager8.xcodeproj"

// TODO: 1. Create the "taskForPOSTRequest" method to extract the code for making "POST" requests. It should be similar to "taskForGETRequest" but with an additional generic and a parameter for the HTTP body - *** note the addition of the "RequestType" generic and the "body" of type "RequestType".

// TODO: 2. Modify the "login()" function in "TMDBClient" to call "taskForPOSTRequest". Pass in your instance of the "LoginRequest" struct as the body.

// TODO: 3. In the completion handler, if the JSON response is not nil, set the "requestToken" in the "Auth" struct and call the completion handler with "true" for "success" and "nil" for the "error".

// TODO: 4. Modify the "createSessionId" function in "TMDBClient.swift" to call "taskFORPostRequest". Pass in your instance of the "PostSession" struct as a parameter.

// TODO: 5. In the completion handler, if the JSON response is not nil, set the "sessionId" in the "Auth" struct and call the completion handler with "true" for "success" and "nil" for the "error".

// TODO: 6. Move any calls to "DispatchQueue.main.async()" out of the View Controllers. Instead, wrap each call to the completion handler in the async block. That way, you'll never need to skip to the main thread after making one of the requests.

//: [Next](@next)
