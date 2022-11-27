//: [Previous](@previous)

import Foundation

// MARK: 13. Feature: Poster Images in Watchlist

/*
 We're almost ready to calling the movie manager complete. There's just one more feature to get everything working: showing poster images in the watchlist and favorites list: show poster images in the watchlist and favorites list.

 The actual code implementation is specific to the movie manager, so let's walk through how this is done on the watchlist. FIrst, let's take a look back at how table views work, and what this means for loading images from the network.
 */

// 00:00 A TableView can scroll a nearly unlimited number of cells. This can take up a lot of memory, especially with large files like these images here. Furthermore, the TableView would need to render UITableView cell for every element in the cell so that the scrolling behaviour remains smooth. This would be highly impractival to do on a device with limited resources such as an iPhone. Thankfully, Apple's engineers recognized this problem and UITableView doesn't actually draw every single cell at once. Instead, only a handful of cells are stored in memory by default, enough for every cell on the screen, plus few extras for smooth scroling. These are known as reusable cells. When the user scrolls down, the cells get added to the pool of available cells as they go off screen. Then, the next available cell, which may be a cell that was already used, is removed from the pool and populated with the information needed to render the cell.
// 01:01 This is what happens every time when you call "dequeueReusableCellWithIdentifier". Eventually, even cells that have already been rendered with information from one object will be overwritten with the information from another object.
// 01:12 At this point, the old cell is so far off the screen that we no longer need to knkow what it looks like until the user scrolls back down. This leaves us with two important takeaways when working with TableViews:

    // 1. MARK: "cellForRowAtIndexPath" is not always called for every cell.
    // the mehtod for configuring the cell is only called for cells that need to be shown on screen. As a result, we don't actually need to load images into the cells until we need to.

    // 2. MARK: "cellForRowAtIndexPath" can be called multiple times per cell.
    // 01:37 is pottentially called multiple times for each cell. So we don't want to duplicate work, especially in network intensive to escalate downloading an image. Thankfully, URL session catches responses for us so that we don't have to worry about this unless we're optimizing our code later. RIght now, we're concerned with the 1st one (1st download only). While it's tempting to just download images all at once, we can avoid this by downloading the images on a per cell basis. In other words, we'll perform each image download in "cellForRowAtIndexPath" so that the TableView can decide which image file needs to be downloaded.

// 02:13 Let's see what this looks like in code ... previous teory comments see in "13. Feature: Poster Images in Watchlist" playground. Here I am in the "WatchlistViewController.swift" ... see comments in "TheMovieManager13.xcodeproj" ... 02:19 // All we do right now is set the label to the ... move to "WatchlistViewController.swift"


// MARK: Task - Add the necessary code to get images to appear in the favorites list.
// See solution done within "TheMovieManager13.1.xcodeproj".

//: [Next](@next)
