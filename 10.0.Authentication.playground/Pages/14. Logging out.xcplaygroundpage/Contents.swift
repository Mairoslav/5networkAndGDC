//: [Previous](@previous)

import Foundation

// MARK: 14. Logging out
// as per "TheMovieManager6"

// 00:00 We have talked a lot about loggin in and implemented two authentication flows. The one missin piece is what to do when user has finished their session. In other words, how to log out?

// 00:13 The button in the top left of the movie manager dismisses the tab view returning to the log in screen. However the user is still technically authenticated.

// 00:23 To log out we can delete the session. This will invalidate the session ID for future requests. This method is a new type of HTTP request, called the delete request: DELETE /authentication/session as per https://developers.themoviedb.org/3/authentication/delete-session but everything else on this page is just like you have seen. 00:37 The request takes the API key as a query parameter, it accepts your request body within the sessioId, and it returns a response with a success property.

// 00:47 For the Movie Manager app, we're not really concerned if logging out fails, so you do not have to parse the response. But the documentation shows that if you do need to, than this is the format in which the response is returned - see "Responses" in documentation.

// 01:01 The only difference between this and say a post request is the HTTP method delete.

// 01:03 When the logout button is tapped, the logoutTapped method in "UIViewController+Extension.swift" is called. This is where you'll call to logout function which you'll create TMDB client. In its completion handler, you can then call "dismiss" on the ViewController to return to the login screen. I have provided a detailed list of steps below to add the logout function to TheMovieManager. Even though this is DELETE request, all the steps should be familiar and you can refer to the documetation for how to format request and response.

// MARK: QUIZ QUESTION: Refer to the documentation* for DELETEing a session, and perform the following steps to implement the logout button. * https://developers.themoviedb.org/3/authentication/delete-session

// TODO: 1.0 add a "logout" case to the "Endpoints" enum
// TODO: 1.1 and build the correct URL for "stringValue"

// TODO: 2.0 create a Codable truct for the request body in "LogoutRequest.swift"

// TODO: 3.0 create method in "TMDBClient.swift" with an appropriate completion handler. The completion handler does not need to pass back any values (unless you choose to handle errors or parse the results).

// TODO: 4.0 Create a URLRequest using the "logout" case

// TODO: 5.0 Set the "httpMethod" to "DELETE"
// TODO: 5.1 and "Content-Type" to "application/json".

// TODO: 6.0 Make the request, and call the completion handler where appropriate. Set the "requestToken" and the "sessioId" in the "Auth" struct to an empty String. You do not need to parse the result for this exercise, sinc ethe user will be logged out anyway.

// TODO: 7.0 Call the "logout" method in the "logoutTapped" function in "UIViewController+Extension.swift".

// TODO: 8.0 In the completion handler, dismiss the view controller on the main thread.

//: [Next](@next)
