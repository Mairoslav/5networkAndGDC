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
            TMDBClient.downloadPosterImage(path: posterPath) { (data, error) in
                guard let data = data else {
                    return
                }
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        }
        
    }
    
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
