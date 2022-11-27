//: [Previous](@previous)

import Foundation

// MARK: 12. Feature: Poster Image on Detail View
// check also file "TheMovieManager12.xcodeproj"

// MARK: video1
// Our movie manager app is comming along well, but it still looks little boring. Let's talk abouit how we can get images to make our app more visually appealing.
// 00:13 In the detail view, we'll start by replacing this blank space with the movie's poster image. In the codumentation for the movie database, there's a page https://developers.themoviedb.org/3/getting-started/images dedicated to how to retrieve images and we can see the format for the URL:
// https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg and ther is more information, for now I just want to draw your attention to this value, that is a part of a url here:
// /kqjL17yufvn9OVLyXYpvtyrFfak.jpg
// 00:37 This is the "poster_path" of an image returned by the movie database. // 00:41 In the movie manager app the struct Movie in "Movie.swift" has a property for the poster_path "let posterPath: String?" as we can use this to build the URL for any poster image.
// 00:51 To keep consistent with our other requests, you can add the case to the Endpoints enum to build the URL for an image. Since the "posterPath" comes from an instance of the movie struct you can take advantage of associated values like we did for the search endpoint to build the URL.
// 01:06 Once you have the URL, you can add a new method to the TMDBClient.swift (at the bottom) ... move there ...

// 01:06 Once you have the URL, you can add a new method to the TMDBClient.swift (here at the bottom) that handles downloading an image file. You will need to know the poster path with an image to retrieve as well as take a completion handler with the downloaded data and an error, there are many ways to do this, but you can refer to the exaample in the run dog app if you need to, all the steps should be familiar at this point.
// 01:26 Then you call this method in the "MovieDetailViewController.swift" in "viewDidLoad()". ... move there ...

// 01:26 Then you call this method in the "MovieDetailViewController.swift" in "viewDidLoad()". In the completion handler, be sure to convert the data to an image and set it to the "imageView" up here (see line 13 "@IBOutlet weak var imageView: UIImageView!") on the main thread. Again, all of this is just like what we did in ranDog app and detailed steps are provided below the video. But it is important for you to go through this exercise to practice. Check off each step as you complete the tasks, than when you run the app, you should see the poster image in the detail view.


// MARK: QuizQuestion - Create a new method for downloading the image by following the steps.

// MARK: 1. Add a case to the "Endpoints" enum for a "posterImageURL" with a "(String)" associated value. THe URL can be constructed, by concatenating the base https://image.tmdb.org/t/p/w500 + and the "posterPath". The "posterPath" comes from a "Movie" struct and can be passed in via the associated value.

// MARK: 2. Create a new "class" method in "TMDBClient" called "downloadPosterImage" for downloading the file. It should take two parameters, a "String" for the "posterPath" and a completion handler that takes two parameter of type "Data?" (the raw image data) and "Error?".

// MARK: 3. Make a network request to download the image with the poster path. Either a "dataTask" (like in ranDog app) or a "downloadTask" will work. Be sure to call the completion handler to pass back the "data", and "error".

// MARK: 4. Call "downloadPosterImage" in the "viewDidload" method of "MovieDetailViewController"

// MARK: 5. Convert the downloaded data to a "UIImage" (if it's not "nil") and set it in "imageView". Be sure all UI updates happen on the main thread.

// MARK: video2
// 00: ...

//: [Next](@next)
