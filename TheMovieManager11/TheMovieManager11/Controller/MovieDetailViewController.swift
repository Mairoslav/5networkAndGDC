//
//  MovieDetailViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var watchlistBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    
    var movie: Movie!
    
    var isWatchlist: Bool {
        return
            MovieModel.watchlist.contains(movie)
    }
    
    var isFavorite: Bool {
        return
            MovieModel.favorites.contains(movie)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = movie.title
        print("viewDidLoad")
        toggleBarButton(watchlistBarButtonItem, enabled: isWatchlist)
        toggleBarButton(favoriteBarButtonItem, enabled: isFavorite)
        
    }
    
    @IBAction func watchlistButtonTapped(_ sender: UIBarButtonItem) {
        print("watchlistButtonTapped")
    // 04:36 We'll call this one ("class func markWatchlist" from "TMDBClient.swift") on the "@IBAction func watchlistButtonTapped" in the "MovieDetailViewController.swift". Passing in the "movie.id". The starter code for TheMovieManager has "var isWatchlist: Bool" property above in line 19, which will be true if the movie is on the watchlist, and false if not. 04:49 By tapping the button, we change whether or not this is on the watchlist. So, I am going to negate it using the not operator (!). For the completion handler, I just created another method to handle the resonse called "handleWatchlistResponse", check it below this function.
        TMDBClient.markWatchlist(movieId: movie.id, watchlist: !isWatchlist, completion: handleWatchlistResponse(success:error:))
    }
    
    // 04:56 For the completion handler above, I just created another method to handle the resonse called "handleWatchlistResponse".
    func handleWatchlistResponse(success: Bool, error: Error?) {
        // if the response was successful, there are either two things that happen, 1. the movie was added to the watchlist, or 2. it was removed.
        if success {
            print("success")
            // So, we'll get "isWatchlist" value again. Even though the watchlist has changed in the movie databases server, we have yet to update it in our app. So, if the movie is on the wachlist, tapping button means we  successfully deleted it from watchlist.
            if isWatchlist {
                // So I'll set the "watchlist" and the "MovieModel" to every movie that's already in the watchlist, except for the one we deleted using filter.
                MovieModel.watchlist = MovieModel.watchlist.filter()
                { $0 != self.movie } // if use 1: "Contextual closure type '(Movie) throws -> Bool' expects 1 argument, but 2 were used in closure body"
            } else {
                // 05:28 If it's not on the watchlist already, that means it was successfully added there after tapping the button. So we can just append it to the watchlist and the MovieModel
                MovieModel.watchlist.append(movie) // add movie
            }
            // 05:36 Finally, I call "toggleBarButton" to update the UI, passing in the "watchlistBarButtonItem, and the new value for "isWatchlist". Now when we run the app and search for a movie, we can tap the watchlist on the detail page which becomes highlighted. Navigating back to the watchlist ViewController (i.e. 1st screen and mid button), we can see that this movie has been added to our watchlist. If we go back to the detail view, the button remains hihglighted, letting us know that this movie is on the watchlist. Tapping the buttn again will reset it to the non-highlighted state. If we navigate back to the watchlist, we can see that the movie has been removed. A lot of the logic we have here is specific to the movie manager, but the key takeaway is that you can make a POST request ("class func markWatchlist" has POST request that's why) just as easily as you maike a GET request. The only additional step is in passing the request body for task for a POST request. THen when you make changes to the data on the server, it is important also to do those changes on the client. If the data is not in sync or if the UI doesn't get updated correctly, this can get really confusing for your users. So we always update the state, when we know that a request has succeeded.
            toggleBarButton(watchlistBarButtonItem, enabled: isWatchlist)
        } else {
            print("failure")
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        
    }
            
    
    func toggleBarButton(_ button: UIBarButtonItem, enabled: Bool) {
        if enabled {
            button.tintColor = UIColor.primaryDark
        } else {
            button.tintColor = UIColor.gray
        }
    }
    
    
}
