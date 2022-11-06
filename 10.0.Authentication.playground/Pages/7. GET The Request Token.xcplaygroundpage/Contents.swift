//: [Previous](@previous)

import Foundation

// MARK: 7. GET The Request Token - video 1

// 00:00 As we've seen, the first step to authenticate with the movie database is to create a request token. We do that with this Endpoint: GET /authentication/token/new. It's a GET request. And it looks like it takes one query parameter which is the API key, see "Query String" on https://developers.themoviedb.org/3/authentication/create-request-token

// 00:19 It also returns a JSON response with the format down here, see "Responses" on web site. We saw query parameters earlier in this course, but we have yet to use them with the Web Surface. Let's review what the URL looks like when parameter are added.

// 00:32 The movie database has this cool feature where you can execute requests directly in your browser. If I scroll up and click the "try it out" button, you will see this screen where you can specify the different query parameters, and see how they change the request. Under Variables there is just one parameter called API key. And looking at the URL, we can see that after the Endpoint, we have a questionmark (?) followed by the name of the query parameter, in this case "api_key" followed by equal sign (=), and finally the actual API key String.  https://api.themoviedb.org/3/authentication/token/new?api_key=<<api_key>> So we have all the information to construct the URL. Let's see what this looks like in our app.

// 01:12 Subsequent query parameters are separated by an ampersand "&" such as the URL we used to getWatchlist... further check comments in Xcode project "TheMovieManager2". 

// MARK: text under video 1

/*
 Head over to the documentation https://developers.themoviedb.org/3/authentication/create-request-token to refer to as you get the request token.
 
 Reflect 1: Alright, so we know the endpoint is /authentication/token/new. Scrolling down to the "Query String" section, what else is required to build the URL? No wrong answer.
        // Me : We first add the "apiKeyparam" (REQUIRED), and we also specify the "session_id", as said this and further query parameters are separated by an ampersand "&" as can see above "&session_id=\(Auth.sessionId)".
        // Udacity: The "Query String" section lists the query parameters for the URL. There's one "required" parameter, the api_key. So to build the URL, you'll need the base URL (Endpoints.base), the endpoint (/authentication/token/new) and a query parameter for the API key (Endpoints.apiKeyParam).
 
 Reflect 2: Looking at the "Response" section, what values are returned if the request was successful? Now wrong ansewer. Me ... Udacity: ...
 */

// TODO: Now that you have the necessary information from the documentation, perform the following steps in The Movie Manager to get the request token - doing this in Xcode project "TheMovieManager2".

// 1. Add a new case to the endpoints enum called "getRequestToken"

// 2. Add a case to the "switch" statement for "stringValue". Build the URL from the base URL, the Endpoint, and the API key query parameter.

// 3. Create a "Codable" struct in "RequestTokenResponse.swift" to model the response with an appropriate "CodingKeys" enum.

// 4. Add a "class func" to "TMDBClint" to get the request token. use the "getRequestToken" case as the URL. The completion handler should pass back two values, a "Bool", and an "Error?". Pass in "true" if parsing (getting the request token succeeds), otherwise pass in "false". Use the "getWatchlist" method as a guide.

// 5. In your "getRequestToken" method, if the token is successfully created, set "Auth.requestToken" to the request token.

// 6. Call the "TMDBClient.getRequestToken" in the "loginTapped()" function in "LoginViewController"

// 7. Use a trailing closure, or function as the completion handler and print "TMDBClient.Auth.requestToken" to verify the result.

// MARK: 7. GET The Request Token - video 2

//: [Next](@next)
