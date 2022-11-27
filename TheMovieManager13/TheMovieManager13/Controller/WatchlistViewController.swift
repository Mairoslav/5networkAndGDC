//
//  WatchlistViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

// MARK: 13. Feature: Poster Images in Watchlist
// WatchlistViewController.swift /

// 02:13 Let's see what this looks like in code ... previous teory comments see in "13. Feature: Poster Images in Watchlist" playground. Here I am in the "WatchlistViewController.swift"

class WatchlistViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TMDBClient.getWatchlist() { movies, error in
            MovieModel.watchlist = movies
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
            detailVC.movie = MovieModel.watchlist[selectedIndex]
        }
    }
    
}

extension WatchlistViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieModel.watchlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell")! // ...ViwCell", for: indexpath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) // above code was here by default, while in video is this code. Both do work.
        
        let movie = MovieModel.watchlist[indexPath.row]
        
        // 02:19 All we do right now is set the label to the "movie.title".
        cell.textLabel?.text = movie.title
        
        // We already added a method to download the poster image in the previous step so we just need to call it. First, like we did in the "MovieDetailViewController.swift", I'll check if the movie has a "posterPath".
        if let posterPath = movie.posterPath {
            // if so, we'll call "downloadPosterImage" and pass in the poster path. For completion handler, because "data" is optional, we'll unwrap it using a guard statement.
            TMDBClient.downloadPosterImage(path: posterPath) { (data, error) in
                guard let data = data else {
                    return
                }
                // 02:44 Again, we can create a new image using the UIImage class, passing in the data we have just un-wrapped,
                let image = UIImage(data: data)
                // and once we have the image, we can set it in the "ImageView" of the cell.
                cell.imageView?.image = image // 02:54 By default, UITableView cells have this "ImageView" property. In our case, the ImageView will appear to the lef of the text. So we've set the image in our ImageView, it should shop up in the TableView. Bus as far as the "TableView" is concerned, this cell has already been rendered on the screen. If the user doesn't interact with the "tableView" cell, the image may not show up immediatelly, and that's not what we want. Thankfully, there's a handy method we can call to force the view to update its contents. And that's cell.setNeedsLayout.
                cell.setNeedsLayout()
                // 03:27 I've linked the documentation for the official explanation of what this does, but just know that we need to refresh the cell so that images actually appear. Now if we run the app, we can see all the poster images appear on the watchlist. Not all of the images are boing downloaded at once, but rather, each download occurs as the cell comes on screen. And because we said setNeedsLayout(), the cells are updated immediately. This is a great way to handle image downloads in a "tableView". If you were to have a lot of movies on your watchlist, this would conserve valuable network resources, benefiting both their users and the performance of your app.
                // 04:02 All it takes is to prefer on the downloaded in "cellForRowAtIndexPath" as can see here above "TMDBClient.downloadPosterImage(...", and the tableView takes care of the rest. This same approach can be used for any tableView. Try implementing the same functionality in the favorites list and then run the app to see it in action. So move to file "FavoritesViewController.swift" ...
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


