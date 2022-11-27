//
//  FavoritesViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

// MARK: 13. Feature: Poster Images in Favorites - as per final task

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TMDBClient.getFavorites { movies, error in
            MovieModel.favorites = movies
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! MovieDetailViewController
            detailVC.movie = MovieModel.favorites[selectedIndex]
        }
    }
    
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath)
        let movie = MovieModel.favorites[indexPath.row]
        cell.textLabel?.text = movie.title
        
        // check if the movie has a "posterPath"
        if let posterPath = movie.posterPath {
            // if so, we'll call "downloadPosterImage" from "TMDBClient.swift" and pass in the poster path. For completion handler, because "data" is optional, we'll unwrap it using a guard statement.
            TMDBClient.downloadPosterImage(path: posterPath) { (data, error) in
                guard let data = data else {
                    return
                }
                // create a new image using the UIImage class, passing in the data we have just un-wrapped
                let image = UIImage(data: data)
                // set the image in our ImageView within the tableView cell
                cell.imageView?.image = image
                // force the view to update its contents
                cell.setNeedsLayout()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
