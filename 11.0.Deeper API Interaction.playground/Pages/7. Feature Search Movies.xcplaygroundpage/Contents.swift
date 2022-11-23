//: [Previous](@previous)

import Foundation

// MARK: 7. Feature Search Movies

// MARK: video1
// 00:00 On The Movie Database (TMDb) website when we first added movies to our favorites and watchlist, we were able to type a query into the search box. When we hit enter, we were presented with a list of search results like this ... We are going to do something similar in TheMovieManager app.

// 00:19 For this exercise, I am not going to tell you exactly how we could search for movies. THis will be opportunity to research the movie database's documentation and determine what request we can make to implement this feature. Being able to read unfamiliar documentation and turning it into functional code is an essential skill for any iOS developer, and is best learned through practice.

// 00:39 First, see if you can identify the endpoint that is used to search for movies. It'sd located under one of these categories on the left-hand side on this web site: https://developers.themoviedb.org/3/getting-started/introduction and it's the method specifically for searching movies. Once you found the correct endpoint, answer the questions below about making that request and the response that it returns.

// MARK: task - Head over to the documentation for the movie database. What is the endpoint (path) for searching movies?
// my response: GET /search/movie
// Udacity response: Correct, we can search for a movie using the /search/movie.

// MARK: quiz1 - What query parameters are required for this request?
// my response: api_key and query
// Udacity response: Yes, the method for searching movies takes many parameters, but only the "api_key" and the "query" are required for making this request. Unlike other requests we've made, the "request_token" is not required, which means searching for movies does not require authentication.

// MARK: quiz2 - What values are returned as the JSON response?
// my response: page, results, total_results, total_pages
// Udacity response: Correct, of the responses listed, the JSON contains the "page" of search results as well as a "results" property, which is an array of movies. This response is in the exact same format as our "MovieResults" and "Movie" structs.

// MARK: video2
// 00:00 Thanks for taking the time to browse the documentation. We can use that knowledge to implement the search feature in the movie manager. The method is located down here on left-side in the SEARCH category and the endpoint is just "search/movie". Like all other methods, this one requires an "api_key" as a query parameter. There is also the String parameter, called "query", which is just the search term we type in the search box.

// 00:26 Scrolling down to the response, we can see that this looks familiar from the other methods. The resonse is in the same format as the request to get the watchlist and favorites list. There is some integer values for information such as the "page" of search results and there's also an Array of movies. This means that we do not need to add any more model objects to implement the serach feature. We can simply parse the movie results struct we already have.

// 00:53 To make this request, we first need to buld the URL. I add the "search" case here to the endpoint enum ... for detailed comments see "TheMovieManager10.xcodeproj"

//: [Next](@next)
