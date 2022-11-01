//
//  MovieModel.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

// 5. Movie Manager Tour, // 03:22 We store our app data in MovieModel.swift file, move there... THe Arrays of movies ar stored in the "watchlist", and the MovieModel also contains an Array for the favourites list.
// There are a lot more swift files into these groups. TMDB responses, the data we'll get back from the requests, and TMDB requests, the data will send to to server. All of these are empty files and you'll be adding Codable structs later on. For now let's see how this looks in the ViewController, move to "WatchlistViewController.swift"...

class MovieModel {
    
    static var watchlist = [Movie]()
    static var favorites = [Movie]()
    
}
