//: [Previous](@previous)

import Foundation

// MARK: 5. Starting the Project

/*
 00:00 All right. So, we know what endpoint we want to use. It's time to setup our Xcode Project and start coding. This will be a Singel View App. Going to call it Randog.
 
 00:19 Now the first thing I like to do with every project is to clean up what's over here on the project navigator to separate it into MVC (Model View Controller) components. Select:
 
    - Main.storyboard
    - Assets.xcassets
    - LauchScreen
 
 Right click / choose New Group from Selection / call it View .
 
 00:45 In more complex projects we might want to make a separate group called Assets and separate this from the View group, but our goal is to make all the files easy to find.
 
 00:53 Also going to select the:

    - AppDelegate.swift, and
    - ViewControlle.swift
 
 And create new group from this selection, called Controller.
 
 01:04 Great so now we are ready to build the View. And we'll neeed an image view from the objects library up here. From here we can drag it onto the ViewController (and widen it by draggint to whole screen) and I am going to use the Add New Constrainnts tool, leaving the default margins on all sides (by clicking on the lines that do represent constraits, so that lines do become red)

 01:23 Finally, let's set this imageView content mode to Aspect Fit (good, has been alrady set as default). So that we'll be able to see the full image and it will not be stretched in anyway.
 
 01:33 Now we are ready to hook this view up as an IPOutlet. I am goint to close the document outline (names of views, constraints... left next to the storyboard) to give us more room and then open the Assistant Editor.
 
 // MARK: iOS : No Assistant Results
 
    clean derived data
    https://www.youtube.com/watch?v=yZUH6whtr9U
    https://www.youtube.com/watch?v=uMGiMkMZjXs
 
    Xcode/preferences/Locations/click on arrow under Derived Data/will be navigated to folder Derived Data/go to folder Derived Data/select all/remove to bin/quit~restart Xcode/if necessary refractor/rename name of class in ViewController as explained in link below:
 
    https://aramsdale.medium.com/swift-resolving-no-assistant-results-in-xcode-12-check-this-first-6d078ec91ff6
    
 01:48 Open Assistant by Control+Option+Command+Enter. Here we can drag over our Outlet. Let's call it imageView. Now close Assistant by Command+Enter. Here in Main.storyboard what we see it the entire UI of our project. We have an imageView that we can load the random image into and we know what endpoint we're going to get that image from. So let's add that to our project next.
 */

//: [Next](@next)
