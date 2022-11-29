//
//  SearchViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [Movie]()
    
    var selectedIndex = 0
    
    // 03:05 Back at "SearchViewController.swift" we need a way to cancel this ongoing task if any, when a new character is typed but we don't have access to the previous download task when this function is called for each subsequently typed character, what we can do however is store the current task as a property.
    // 03:21 I'll call this "currentSearchTask:" and the type will be URLSessionTask. It's also an optional because the task could be nil - for example when we first lauch the ViewController, no download is taking place.
    var currentSearchTask: URLSessionTask?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! MovieDetailViewController
            detailVC.movie = movies[selectedIndex]
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 03:36 Finally, in the "searchBar" delegate method, we'll cancel the current search task if any.
        currentSearchTask?.cancel()
        // 03:42 And now every time we create a task, its returned by the "search" method, so I can update the current search task here by adding "currentSearchTask =" below. That's the point.
        // Let's run the app with bad network, and as I start typing in search, instead of seeing a list of all the movies keep getting updated, the list is just blank. And eventually, the list populates. This is not only the expected behaviour for the search bar but only completes the network requests that are needed, saving the user data and making our app more responsive.
        // MARK: Tip: **** Getting warnings about the unused return type from taskForGETRequest? Use the "@discardableResult" annotation to silence them, just add "@discardableResult" in front of the "class func taskForGETRequest" within "TMDBClient.swift".
        currentSearchTask = TMDBClient.search(query: searchText) { (movies, error) in
            self.movies = movies
            self.tableView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell")!
        
        let movie = movies[indexPath.row]
        
        cell.textLabel?.text = "\(movie.title) - \(movie.releaseYear)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
