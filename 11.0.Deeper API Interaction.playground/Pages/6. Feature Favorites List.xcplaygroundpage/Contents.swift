//: [Previous](@previous)

import Foundation

// MARK: video1
// 00:00 Now that we have done some refactoring to make our networkng code more reusable, let's try adding a new feature to TheMovieManager. We want the user to be able to view the movies on their favourites list. We already have a similar feature for the watchlist. But if we go tho the favorites tab, we just see an empty table. Let's take a look back at our code to see how we might implement this feature.

// 00:22 Ever since the refactoring the "getWatchlist" method just calls "taskForGETRequest". Our endpoints enum has a case called "getWatchlist" that we can use to pass in the url - see "taskForGETRequest(url: Endpoints.getWatchlist.url..."

// 00:35 We also have a Codable struct called "MovieResults" that matches the JSON response - see "response: MovieResults.self..."

// 00:39 Then in the completion handler we check if the request was successful and either pass back an array of movies or an empty array if it was not.

// 00:47 As we saw in the last lesson, the "MovieResults" struct has a few properties: page, totalPages, totalResults, as well as the results Array. This in an Array of movies, if we go to the definition (Control + Command + click on it / or Option + click and then click on XY file name written under title "Declared in") we can see that Movie is another Codable struct that contains a lot of properties about a specific movie.

// 01:08 The "watchlist" from "MovieModel.swift" is displayed in "WatchlistViewController.swift" ans we call "getWatchlist()" in "viewDidLoad()" function. We hit an Array of "movies" back, which is assigned to the "watchlist" array in "MovieModel", and of course, we need to "reloadData()" on the "self.tableView", being sure to jump to the main thread via "DispatchQueue.main.async {..."

// 01:24 Actually, since we refactor "taskForGETRequest", we really do not need this call to async() anymore, so can just remove it.

// 01:30 The "watchlist" functionality was implemented based on the information in the documentation - see link below.
        // https://developers.themoviedb.org/3/account/get-movie-watchlist *

// 01:35 Like the other methods, we can see the type of request is GET, and we can also see the Endpoint:
        // GET /account/{account_id}/watchlist/movies *

// 01:41 FOR The query parameters under title "Query String" on the same web page, we can see that manyu of these are marked "optional". The only ones required are the API_key and the session_id we obtain after loggin in.

// 01:51 We also have a response - see title "Responses" - if the response was successful, should share the same format as our "MovieResults" struct.

// 01:57 The one interesting thing to note about this method (pointing on {account_id} as written in the link above) is the path parameter here for the "account_id". This is an Integer that uniquely identifies an account with the movie database. The idea is that if you knopw the account_id of the user, you can pass it into this method to retrieve their Watchlist. However, TheMovieDatabase doesn't actually implement this functionality as per current version. So whichever integer you provide for the path parameter, it will always return the array of movies for the currently logged in user. In TheMovieManager, notice how in the Auth struct, we just have our property for the account_id, which is set to zero. It is not modifies anzwhere in the code but we just need to pass it in when we make the request.

// 02:37 The request for the .favorites list is nearly identical to the one for getting the .watchlist. The endpoint is slightly different, but still takesa the account_id as path parameter (see {account_id} within the GET /link... on web*). The only required query parameters, again, are the "api_key" and the "session_id", and the ResponseType within ("Responses" - as per web) is exactly the same. If the request is successful, they should parse directly into the MovieResults struct we alrady created. In TheMovieManager app, there's a file "FavoritesViewController.swift" where you can make the request. Detailed steps for implementing the favorites list are below, and you can reference the code for making the Watchlist if you like. The two features really are that similar. Check-off each box as you complete each item on the task list, and then see the solution video.
 
// MARK: Quiz questions - see "TheMovieManager8.xcodeproj"

// MARK: 1. Add a "getFavorites" endpoint to the "Endpoints" enum.
// MARK: 1.1 Be sure to pass in the "accountId" as the appropriate path parameter.

// MARK: 2. Create a "class" function in "TMDBClient" called "getFavorites", that takes one parameter; a completion handler that passes back an Array of movies ([Movie]) and an optional error (Error?). This is similar to "getWatchlist".

// MARK: 3. Call "taskForGETRequest". If the parsing was successful, return the Array of Movies. Otherwise, return an empty array and the appropriate error.

// MARK: 4. Call the "getFavorites" method in "FavoritesViewController". Set the "favorites" Array in "MovieModel" to the result and reload the table view.

// MARK: 5. Run the app to confirm that the favorites list is being populated.

// Great it did work

// MARK: video2
// 00:00 The code for displaying the favorites list is just like the code for diplaying the watchlist. The only difference is the endpoint we're calling, and that we display the favorites list in a different view controller in our app.

// 00:13 The 1st step is to add a new case to our Endpoints enum. This one called .getFavorites, returns a URL based on the enpoint in the documentation. Notice how just like the Watchlist, we pass in the accountId as a query parameter - see \(Auth.accountId), even though this value is ignored by the movie database.

// 00:29 And the method to make the request is called "getFavorites". If the parse is successful, then the Array of movies is passed into the completion handler - as expressed by "response.results, nil". But if not, we just pass in an empty array along with the error.

// 00:44 The result is of type MovieResults as you can see in "response: MovieResults.self)". That's because the format of the response is exaclty the same as the request to get the watchlist.

// 00:51 In "FavoritesViewController.swift", all we need to do is to call a "getFavorites" method on TMDBClient. The resulting Array of movies is assigned to the favorites Array and MovieModel and then the tableView is reloaded.

// 01:03 When the app is run, we can now go on to the favorites tab and see a list of movies; and here I can see the one movie that I've added to my favorites. If you haven't favorited any movies yet, then nothing will show up here. So yo can go add favorite movie on the movie databse website to confirmt that the favorites list is working, and soon enough, user will be able to both add and delete movies from directly wiothin TheMovieManager app. 

//: [Next](@next)
