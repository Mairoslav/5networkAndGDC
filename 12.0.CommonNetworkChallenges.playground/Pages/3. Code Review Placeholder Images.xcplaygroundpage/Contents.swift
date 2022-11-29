//: [Previous](@previous)

import Foundation

// MARK: 3. Code Review: Placeholder Images
// see comments also in "TheMovieManager14.xcodeproj"

// MARK: video1
// 00:00 Ludwig: so we know that because not everyone has unlimited data plan, we should be mindful of our user's data limits. Whats one way that our app could better communicate to users that were using the network?

// 00:12 Lin: Good question. One of the movie manager's biggest sources of network usage is image downloads. But the images may not load at the same speed for all users. For example, when I first load the watchlist, I can immediatelly see a list of the movie titles. If I wait for a few seconds, the images start appearing. If the user waits really long time for images to download, they might be surprised to know that the device was downloading all this data in the background, and not to mention, it looks little bit awkward for images to appear in some of the cells when the rest of the cells have none. Now, a common solution to this problem is to use a placeholer image. This means every image view has a standard loading image. Users will then know that an image will be displayed, even if the actual image has been still downloading.

// 00:57 Ludwig: Thanks Jessica. Using a placeholder image sounds like an interesting idea. Let's see how can show the images that are loading in the Movie Manager app. In the "Assets.xcassets" catalogue, there were a couple of images in the project already. This one, the last one, called "PosterPlaceholder", is just a generic icon of a roll of film. Something simple we can use to stand in for images while they are being loaded. To use the images in "WatchlistViewController.swift", ... move there ...  remember that the posters are being loaded into "cellForRowIndexpath" here ... see comments directly in "TheMovieManager14.xcodeproj" at "WatchlistViewController.swift".

// 00:29 So each time this executes, I am going to set the image in the cell to the default value, and that's UIImage, and I'll use the initializer with named:. The name is going to be whatever image is called in the asses catalog within "Assets.xcassets", in our case "PosterPlaceholder".

// 01:47 However, if the image has already been downloaded, it should display immediately since the result has been cached. If not, the placeholder above will still be shown.

// 01:57 Now if we run it, we can see that images load with a placeholder on the watchlist. After that, the images appear as we expect. We have only done this for the watchlist. It's good to have consistent behaviour throughout the app. Take a moment to task1: implement the same thing for the favorites list, and task2: the detail view should show the "PosterPlaceholder" as well.


// MARK: Quiz: Add the placeholder to all other image views that show poster images.

// MARK: 1. Udpate the code in "FavoritesListViewController.swift" to show the placeholder image when the images are loading.
// MARK: 2. Update "MovieDetailViewController.swift" to show the placeholder image while the poster image is loading. You can do this either before the image load (like in the watchlist and favorites list) or by setting the image in the image view via the storyboard.


// MARK: video2
// 00:00 LEt's show the placeholdr in the favorites list and in the detail view. In the favorites list, the images are already being downloaded in "cellForRowAtIndexPath" just like we did in the watchlist.
// 00:13 So here, I'll set the cells' imageVIews image to UIImage, and like before it is going to be named "PosterPlaceholder". Move to "MovieDetailViewController.swift" ...
// 00:22 here in "MovieDetalViewController.swift" we download the image in the same way. Only that instead of downloading multiple images into a table view, we're only downloading a single image and loading it into this image view (see above "@IBOutlet weak var imageView: UIImageView!" in line 13).
// 00:35 We could set the placeholder here when we download the image or as an alternative, we can do it on the storyboard. In "Main.storyboard" selecting the "ImageView" within "MovieDetailViewController" we can set the image witing "atributes inspector" to be "PosterPlaceholder". One coming from the asset catalog and that's it. All our image view should now defaults to the placeholder, letting th euser know that the image download is in progress. 

//: [Next](@next)
