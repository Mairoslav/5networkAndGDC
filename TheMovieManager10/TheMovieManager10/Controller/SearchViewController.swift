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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! MovieDetailViewController
            detailVC.movie = movies[selectedIndex]
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 02:56 The "search" function is going to be called in "SearchViewController.swift", in this delegate method "textDidChange". It is not important how exactly the "searchBar" delegate works, but just know that this is called whenever the "textDidChange" under "searchBar" func changes. Similar to the textField delegate methods discussed in the UIKit Fundamentsls Course, the current text in the search box is "searchText".
        // 03:15 Each time the text changes, we'll call TMDBClient.search and pass in the "searchText" as the query:.
        // 03:22 We'll get an array of movies in the completion handler, along with an error.
        // 03:28 This movie array up there - see "var movies = [Movie]()" - is responsible for populating the tableView with search results.
        TMDBClient.search(query: searchText) { (movies, error) in
            // 03:32 So we'll set it to the array of movies that's returned when we call the search method and then reload the tableView, so that the search results will appear. Let's run the app to see the search results in action. If I start typing I can see some movies are listed and depending on your connection speed, that list should update approximately whenever a new character is typed.
            // 03:55 I am not seeing the movie I want here so I'll add another word and wow, what happeded? In "TMDBClient.swift" around line 65 for "var url: URL {..." it says ... transition there ...
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
