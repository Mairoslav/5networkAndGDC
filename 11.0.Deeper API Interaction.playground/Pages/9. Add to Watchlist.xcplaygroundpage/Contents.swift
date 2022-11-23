//: [Previous](@previous)

import Foundation

// MARK: 9. Add to Watchlist
// comments in "TheMovieManager11.xcodeproj"
// 00:00 I have onpend the documentation for marking the movie on the watchlist. The endpoint is "/account/{account_id}/watchlist", and it's a POST request, so it has "Request Body" as well as the "Responses" body.

// 00:19 The "Request" body asks for the "media_id" of the movie we want to add to the watchlist, as well as the Boolean for whether the movie should be added or removed as written under line "watchlist". This means this one endpoint can be used for both adding and removing movies from the watchlist.

// 00:28 The response tells us whether of not the request was successful. There's "status_code"* which is an integer, and "status_message" to give us more information. *The "status_code" returned by the movie database is not quite the same as the HTTP status codes we got back when making a request, but they are similar.

// This web-page https://www.themoviedb.org/documentation/api/status-codes lists all of the possible status codes returned by the movie database, and their corresponding HTTP stastus codes, as well as the message that's returned along with the response. So, by checking the status codes, we will know whether or not the movie was added successfuly. The status codes of interest to us are if the request is successful, and there are three of these: Status codes 1, 12, 13 are returned for successful requests. 1: Success, 12: The item/record was updated successfully, 13: The item/record was deleted successfully.

// 01:18 Now, I have already played around with the method for getting the watchlist. So, I know that depending on whether we're adding or removing the movie, the status code will either be 1 for success or 13 whether the item was deleted. This is a POST request and not a PUT request so we are not concerned whether or not the record was updated successfully (i.e. we are not interested now in status code 12 that stands for The item/record was updated successfully). As per ... : "The HTTP PUT request method creates a new resource or replaces a representation of the target resource with the request payload".

// 01:38 There are many more status codes that may be of interest to us, and are good for getting specific information about errors. But for now, we'll use this as a simple check if the request was successful. That's all the information we need to implement this feature. It's just a matter of making another POST request.

// 01:54 As always, the 1st step is to add the endpoints to the enum, ... transition to "TheMovieManager11.xcodeproj" to check further comments ...

//: [Next](@next)
