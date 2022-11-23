//: [Previous](@previous)

import Foundation

// MARK: 8. Feature: Add to Watchlist
// 00:00 In the completed Movie Manager, users can manage their watchlist and favorites list from the detail screen. By tapping this button (watchlist down on the left), the color of button changes to blue, meaning the movie is added to the watchlist. So yes, when the button is highlighted, the movies appears in the users watchlist.

// 00:20 Like for the other features, you can add a new endpoint to handle adding and removing movies from the watchlist.

// 00:27 Then, add a method that makes the correct POST request.

// 00:30 In "WatchlistWiewController.swift" you can call your method to add or remove from the watchlist.

// 00:35 This "var isWatchlist: Bool" computed property as defined in "movieDetailViewController.swift" is true if the movie is already in the locally stored watchlist and false if it's not.

// 00:40 When you mark a movie on the watchlist, you'll wanto to pass in the opposite value, so the movie is either added or removed correctly. You will do this in the method "@IBAction func watchlistButtonTapped" in line 37 of "MovieDetailViewController.swift".

// 00:52 Then you'll just need to update the UI. Specifically, the enabled state of the "watchlistBarButtonItem" based on the new state of the watchlist.

// 01:02 Because a lot of this code is going to be specific to TheMovieManager, I do not expect you to implement the entire feature on your own. This is however a good opportunity to give your task group POST request mehtod some work (???). Before we move forward, take another trip to the documentation and see if yo can answer the following questions about adding and removing from the watch list.

// MARK: text under the video
// When reading an API's documentation, practice makes perfect. Head over to the documentation https://developers.themoviedb.org/3/getting-started/introduction and answer the following questions about adding and removing from the watchlist.

// MARK: task1: Locate the page for marking (adding or removing) a movie from the watchlist. What endpoint (path) do we need to request?
// my response: POST /account/{account_id}/watchlist, can find it under ACCOUNT title on the left.
// response by Udacity: Correct, The method for adding to the watchlist is /account/{account_id}/watchlist.

// MARK: task2: What is the name of this method's query parameter?
// What is the name of this method's query parameter?
// my response: account_id
// response by Udacity: Like the methods for getting the watchlist, this one takes the "account_id" as a query parameter.

// MARK: quizQuestion1 - Because this is a POST request, there's also a request body. What values are passed into the request body?
// me: media_id, media_type, watchlist
// Udacity: The request body takes 3 values,
        // a media_type which can either be "movie" or "tv",
        // the media_id which is the integer ID of the movie,
        // and watchlist a boolean for whether or not the movie is being added or removed from the watchlist.

// MARK: quizQuestion2 - What values are returned in the response body?
// me: status_code and status_message
// Udacity: The response JSON has two properties: status_code and status_message.

// MARK: task3: The response body mentions a "status code". This is something specific to the Movie Database and is not an HTTP status code like we've seen. Head over to the TMDB API homepage. Where is the documentation page for status codes?
// me: https://www.themoviedb.org/documentation/api/status-codes
// Udacity: yes correct

// MARK: quizQuestion3 - Which of the following TMDB status codes might be returned if the request was successful?
// me: 1, 12, 13
// Udacity: Correct! Status codes 1, 12, 13 are returned for successful requests. 1: Success, 12: The item/record was updated successfully, 13: The item/record was deleted successfully.



//: [Next](@next)
