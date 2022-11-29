//: [Previous](@previous)

import Foundation

// MARK: 7. Code Review: Handling Errors
// check also "TheMovieManager18.xcodeproj"

// MARK: video1
// 00:00 Ludwig: So Jessica, I know we've talked a lot about the considerations when there are network difficulties as we have seen, these issues can be a major source of bugs in our app. The other thing we need to think about is when something goes wrong, whether the user sends the wrong data to the server or the server fails entirely. Looking at the code right now, what do you think about our approach to handling errors? How could we improve this approach?

// 00:29 Lin: Actually, the movie manager app is doing a good job handling errors. The app still work even when things go wrong. However, we're not doing a great job of handling specific errors, and this can be confusing to our users. Again, on the login view, the user can type anything for the password and username. It's possible that i might have typed the password incorrectly. If I tap login button, the UI updates appropriately and then resets (Actually in my case, if I insert incorrect password, the network activity indicator does rotate to infinite and the UI does not reset, why?). Users know that the login failed but they don't know why. I could have typed the password wrong or there could have been an error on the server. Most apps tell the user if something went wrong so they know how to fix it.
// 01:05 The movie database provides api a lot of custom errors and it would be really great if TheMovieManager could use this information to display more appropriate error messages to our users.

// 01:15 Ludwig: That's a good suggestion. Well, failing silently is not always a bad approach. After all, no one likes to be bombarded with error messages. Sometimes our apps should provide more context for why our request fails. Right now, the Movie Manager is not able to differentiate between errors. We'll explore why and see how we can modify our code to provide specific and informative error messages.

// MARK: video2
// 00:00 So why can't TheMovieManager differentiate between errors? We are passing back errors to the view controller, right? Move to "TMDBClient.swift" ...

// MARK: Recap of video2 - Error handling Recap
// 04:45 Let's recap what we did to implement error handling.

// MARK: recap 1. Parse the error response (TMDBResponse)
// We saw that because our parsing code was not handling movie database specific errors, we could parse the response into a TMDBResponse object to get the status message.

// MARK: recap 2. Conform to LocalizedError
// We then made TMDBResponse conform to the error protocol, more specifically localizedError, to provide a human-readable error message.

// MARK: recap 3. Set errorDescription
// We set the error description to be the statusMessage from the movie database. Below we replaced "statusMessage" from the movie database with text "Seems like Email or Password are wrong".

// MARK: recap 4. Alert user (update UI)
// And use this error to present an alert in login view controller letting user know that an error occured.

// This is a great start to handling errors in TheMovieManager app. But now we're only handling errors for GET Requests. To better understand how the errors are handled, see if you can implement the same behaviour in "taskForPOSTRequest". Then in completion handlers for logging in and creating the sessionId, display an alert with the localized description as the error message.

// TODO: Method to add to LoginViewController
/*
 func showLoginFailure(message: String) {
     let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
     alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
     show(alertVC, sender: nil)
 }
 */

// TODO: QuizQuestion - Modify the code so that specific errors are handled for POST requests.

// MARK: 1. Modify "taskForPOSTRequest" to handle the specific errors. Instead of passing back the parsing error if the first attempt at parsing fails, try to parse the response into a "TMDBResponse". Refer to "taskForGETReqeust" as an example if needed.

// MARK: 2. Display an alert if an error occurs in "handleLoginResponse".

// MARK: 3. Display an alert if an error orrurs in "handleSessionIdResponse".

//: [Next](@next)

