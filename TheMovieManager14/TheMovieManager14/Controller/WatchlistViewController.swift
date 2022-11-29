//
//  WatchlistViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

// MARK: 3. Code Review: Placeholder Images

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
    
    // 00:57 Ludwig: Thanks Jessica. Using a placeholder image sounds like an interesting idea. Let's see how can show the images that are loading in the Movie Manager app. In the "Assets.xcassets" catalogue, there were a couple of images in the project already. This one, the last one, called "PosterPlaceholder", is just a generic icon of a roll of film. Something simple we can use to stand in for images while they are being loaded. To use the images in "WatchlistViewController.swift", remember that the posters are being loaded in "cellForRowIndexpath" here below.
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath)
        
        let movie = MovieModel.watchlist[indexPath.row]
        cell.textLabel?.text = movie.title
        // 00:29 So each time this executes, I am going to set the image in the cell to the default value, and that's UIImage, and I'll use the initializer with named:. The name is going to be whatever image is called in the asses catalog within "Assets.xcassets", in our case "PosterPlaceholder".
        cell.imageView?.image = UIImage(named: "PosterPlaceholder")
        if let posterPath = movie.posterPath {
            TMDBClient.downloadPosterImage(path: posterPath) { (data, error) in
                guard let data = data else {
                    return
                }
                // 01:47 However, if the image has already been downloaded, it should display immediately since the result has been cached as can see here. If not, the "PosterPlaceholder" above will still be shown.
                let image = UIImage(data: data)
                cell.imageView?.image = image
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


