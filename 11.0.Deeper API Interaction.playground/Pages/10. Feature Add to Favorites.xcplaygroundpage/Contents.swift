//: [Previous](@previous)

import Foundation

// MARK: 10. Feature Add to Favorites

// 00:00 In addition to managing the watchlist, users should also be able to add and remove the favorite movies withing the detail view. Again this heart button is highlighted in blue when a movie is on the favorites list, hence movies that are added should show up in the favorites list in the app.

// 00:22 The reqeust body is slightly different from the one for managing the watchlist, so I've provided this "MarkVavorite.swift" file so that you can implement the Codable struct (based on TMDb api documentation).

// 00:30 The response type is the same, so you can just use the "TMDBResponse" struct that we created in the previous video.

// 00:38 Then you can make the request when the "favoriteButtonTapped" is tapped in the detail view controller.

// 00:41 The response will be handled just like we handle the response for marking movies on the watchlist - see "func handleWatchlistResponse". However you want to be checking the favorites array in the movie model instead. 00:50 To make it easy for yourself, you can reference the code in "func handleWatchlistResponse" to implement a new "handleFavoritesResponse" method to use as the completion handler when marking a favorite.

// 01:01 All the steps listed below are just like the feature for marking movies on the watchlist. You just need to implement another POST request and handle the response appropriatelly.

// MARK: implement the method to mark the movie as favorite

// MARK: 1. Add the appropriate endpoint to the "Endpoints" enum

// MARK: 2. Create a struct for the request body. You can add it to "MarkFavorite.swift" file.

// MARK: 3. Create "markFavorite" method in "TMDBClient" that takes the movieId as a parameter, a Boolean flag, and an appropriate completion handler.

// MARK: 4. Make the reqeuest using "taskForPOSTRequest and call "markFavorite"'s completion handlder appropriately.

// MARK: 5. Call "markFavorite" method when the favorite button in the detail view is tapped, with an appropriate completion handler. You can refer to the code for marking the watchlist if needed.

//: [Next](@next)
