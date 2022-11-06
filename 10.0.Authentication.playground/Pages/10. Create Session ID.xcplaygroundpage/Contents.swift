//: [Previous](@previous)

import Foundation

// MARK: 10. Create Session ID - creating this in "TheMovieManager4.xcodeproj"

// video1, see also video2 under the task below
// 00:00 You have made it to the final step of the authentication process. Now, that the user has validated the requestToken, all we need to do is to exchange it for sessionID.

// TODO: Create Session ID - task under the video1
// Head over to the documentation for "creating a session ID" at https://developers.themoviedb.org/3/authentication/create-session and complete the following steps to create the session ID. To do this, there's one more POST request you'll need to make. Let's go through the steps.

// 00:17 Every request needs a URL. So the 1st step is to add another case to the endpoint enum.
// 00:23 You can build the URL by concatenatin the base URL, the endpoint here from https://developers.themoviedb.org/3/authentication/create-session "/authentication/session/new", and the API key parameter.

// TODO: 1. Add a "createSessionID" case to the "Endpoints" enum
// TODO: 2. Handle the "createSessionId" case in "switch" statement to build the URL, by concatenating the base URL, the endpoint, and the API key query parameter.

// 00:30 You'll also crate two Codable structs, one to handle our request body and another to handle the response.
// 00:38 THe reqeuest body can be added to "PostSession.swift", and response to "SessionResponse.swift". All the information needed to implement these structs can be found in the documentation.

// TODO: 3. Create a "Codable" struct for the request body in "PostSession.swift" with an appropriate "CodingKeys" enum
// TODO: 4. Create a "Codable" struct for the response body in "SessionResponse.swift" with an appropriate "CodingKeys" enum

// 00:50 As form making the request, we will need to add another method to TMDBClient. It only needs one parameter, a completion handler, which can be of the same format as the others i.e. being with @escaping, passing back a Boolean and an Error?.

// TODO: 5. Add a "class func" in "TMDBClient" to make the request. It should take one parameter, a completion handler (@escaping closure) that passes back a "Bool" and an "Error?".

// 01:05 Everything else is just going to look like the login method we have just created. You'll configure a URLRequest with your new URL, and set its httpMethod a "POST". 01:15 Be sure to set the content type to "application/json", and the body will be an instance of the "PostSession" struct. You can get the requestToken from the "Auth" struct itself.
// 01:26 And then instead of updating the requestToken after parsing the response, you can just update the "sessionId" in the home struct here (in TMDBClient.swift, in the "Auth" sturct here - see do/catch statement of class func getRequestToken)

// TODO: 6. Implement the steps to make the POST request. The body should be the "PostSession" struct with the "requestToken".

// TODO: 7. The result should be parsed into the "SessionResponse" struct created in the previous step. If the parsing is successful, set the "sessionId" in the "Auth" struct.

// TODO: 8. Call the completion hanlder with the correct values, where appropriate.

// 01:34 you can call your new method in "LoginViewController.swift". I would suggest creating another function just surface the completion handler taking the same parameters a Boolean and an Error like the "handleLoginResponse" function does because we can only create the "sessionId" if the reqeustToken is already been validated, "handleLoginResponse" is where you'll call the method to create the "sessionId" passing in your completion handler function.

// TODO: 9. In "LoginViewController.swift" add a "handleSessionResponse" method that takes a "Bool" and an "Error?" as parameters.

// TODO: 10. Call the "createSessionID" method if the request to validate the requestToken was successful, passing in "handleSessionResponse" for the completion handler.

// 01:56 Once the "sessionId" has been created successfully, perform the complete login segue to transitioin to the tab view. You should start seeing some movies in the Watchlist.

// TODO: 11. In "handleSessionResponse", if the request was successful, call "self.performSegue(withIdentifier: "completeLogin", sender: nil). Be sure to call it on the main thread (async) ~ DispatchQueue.main.async {...

// video2
// 00:00 ...

//: [Next](@next)
