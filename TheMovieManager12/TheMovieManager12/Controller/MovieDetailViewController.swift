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
        
        if let posterPath = movie.posterPath {
            // MARK: 4. Call "downloadPosterImage" in the "viewDidload" method of "MovieDetailViewController"
            // 01:45 Now we can make the reqeust to download the image in the "viewDidLoad()" method withing "MovieDatailViewController.swift". Not every movie has a poster path, in fact, this property is optional. So let's make sure it's not nil before downloading the image.
            // 01:58 THen, we can just call "TMDBClient.downloadPosterImage", passing in the posterPath we just unwrapped and for completion handler, it will return data and an error.
            TMDBClient.downloadPosterImage(path: posterPath) { (data, error) in
                // 02:11 Like with previous requests we can check if we got data back using a guard statements,
                guard let data = data else {
                    return
                }
                // MARK: 5. Convert the downloaded data to a "UIImage" (if it's not "nil") and set it in "imageView". Be sure all UI updates happen on the main thread.
                // 02:17 and if so, we can convert it to UIImage. Note: interesting how "guard let ... else is managed here"
                let image = UIImage(data: data)
                // 02:19 Once we have the image, we can just set it to the image contained in the imageView. This works because the image property of UI imageView is optional (option + click on violet .image to check). So there is no need to check for nil.
                self.imageView.image = image
            }
        }
        
    }
    
    // 02:3 Run the app and now when we load up the detail view, we should see the poster image to appear. Now that you have the ability to show images in our app, we'll use our "downloadPosterImage" method to handle the common, yet quite complex case of handling image downloads in table view, so that we can get images in our watchlist and favorites list.
    
    @IBAction func watchlistButtonTapped(_ sender: UIBarButtonItem) {
        TMDBClient.markWatchlist(movieId: movie.id, watchlist: !isWatchlist, completion: handleWatchlistResponse(success:error:))
    }
    
    func handleWatchlistResponse(success: Bool, error: Error?) {
        if success {
            if isWatchlist {
                MovieModel.watchlist = MovieModel.watchlist.filter()
                { $0 != self.movie }
            } else {
                MovieModel.watchlist.append(movie)
            }
            toggleBarButton(watchlistBarButtonItem, enabled: isWatchlist)
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        TMDBClient.markFavorite(movieId: movie.id, favorite: !isFavorite, completion: handleFavoritesResponse(success:error:))
    }
    
    func handleFavoritesResponse(success: Bool, error: Error?) {
        if success {
            if isFavorite {
                MovieModel.favorites = MovieModel.favorites.filter()
                { $0 != self.movie }
            } else {
                MovieModel.favorites.append(movie)
            }
        }
        toggleBarButton(favoriteBarButtonItem, enabled: isFavorite)
    }
            
    
    func toggleBarButton(_ button: UIBarButtonItem, enabled: Bool) {
        if enabled {
            button.tintColor = UIColor.primaryDark
        } else {
            button.tintColor = UIColor.gray
        }
    }
    
}
