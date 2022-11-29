//: [Previous](@previous)

import Foundation

// MARK: 4. Code Review: Show Network Activity
// see comments also in "TheMovieManager15.xcodeproj"

// 00:00 Ludwig: Using placeholder images definitelly helps to improve the user experience by showing users where image downloads do occur. But what about other parts of the app? Is there anywhere else where we could better signal network activity?

// 00:16 Lin: Good question, there actually is. So while images downloads use a lot of data, we should also signal narrower activity for requests that just take a long time to finish. This is expecially important if the user is on a slow connection, and can simulate many different types of network connections using the "network link conditioner". This is the tool provided by Xcode to test your app when networks are slow or just not working at all. Complete instructions to set up "network link conditioner" are linked down below this vide.

// 00:46 You can select a profile from the drop-down menu to simulate a slow network... for further details see youtube video below ...

    /*
     MARK: Xcode - How to Simulate a Poor Network Connection | Device & Simulator
     https://www.youtube.com/watch?v=5gAD9amWkQw Window/Devices and Simulators/ on the left under "Devices" window you shall see your iPhone that is connected to iMac.
     Scroll down and you see the "Device Conditions" down here that is set by default to "none". After you change it to the "Network Link" below you can see all the options you have. Can choose "very poor network".
     01:12 Now have to hit "start" and you'll see the gray icon in the upper left of your phone. You can "stop" it by tapping on the gray button on the phone or "stop" button in the Xcode.
 
     02:12 On simulator is is bit more complicated. Let's see. Here I am at developer.apple.com account https://developer.apple.com/download/all/?q=Additional%20Tools . Make sure you have selected the proper team if you have more of them. Choose section "Downloads", here you see "Additional Tools for Scode 12". Click download that, open up that download, click "Hardware" folder / Network Link Conditioner / double click on that and hit install / insert password / now can close it.
     03:23 Now when I go to System Preferences I can see it down there. After opening it can again choose network speed and turn it ON.
     */

// 00:45 After having selected the slow network from drop-down menu, if we try to log-in, we can see that nothing is happening. Tap login again, still nothing again. Now, this type of behaviour makes your app look like it's unresponsive, when in reality it's just th euser's connection is slow.

// 01:09 Ludwig: We cetainly do not want users to wonder why our app isn't working. Many apps will update the UI to show that network activity is in progress and that the app is in fact responsive. We'll use one of these techniques to address this issue in the movie manager.

// 01:23 We're going to signal network activity using a new view called "UIActivityIndicatorView". "UIActivityIndicatorView" does show small spinning circle to show that the app is busy with a long-running task, such as a network request. In library search for "Activity Indicator View", within "Main.storyboard" we'll drag it into the "LoginViewControllerScene" right below our "Login via Website" button. Buttons text fields and labels here are actually just contained in a vertical stack view.

// 01:59 So I'll pin the "activity indicator view" to the bottom of that stack view, using the vertical spacing constraint(click + control + drag to "stack view" on the left panel).
// 02:05 We should also center it horizontally (click + control + drag to any area of screen) so they will be in the right spot.

// 02:08 Over on the "atributes inspector", there are few properties that can be configured, like the color, size or style of the "Activity Indicator View". The one property that can be ticked on/off is "Hides When Stopped", and because we only want the "Activity Indicator View" to be shown with the network activities in progress, it should be hidden by default. Checking (selecting on) this property and choose that whenever the activity is not spinning, it will be hidden from the user and we don't have to hide it ourselve. Put it another way, checking this property means less code to write, which is never a bad thing.

// 02:40 To access "Activity Indicator" from our view controller, we need to add an element from the "assistant editor". Just like any other view, I'll scroll up to where my other outlets are located and drag it to the "LoginViewController.swift" i.e. click + control + drag there (thaks to opening Assistant Editor - having two windows next to each other. I'll call this outlet "activityIndicator".

// 02:55 Now let's close the "assistant editor" and "attributes inspector" and  go back into the "LoginViewController.swift". Our next task is to determine where to start and stop the spinning animation on the activity  indicator, and that depends on whether or not the usr is logging in.
// 03:11 I am going to integrate a new helper function called "setLoggingIn", so that we can uπdate the UI appropriately when the user is logging in. It will take a single Boolean parameter "_ loggingIn: Bool" which will be ture if we're currently loggin in and false if we're not.
// 03:26 If we are loggin in, that means we're accessing the network, so we want to signal network activity ... see comments in "LoginViewController.swift"

/*
 MARK: Getting the Network Link Conditioner
 The Network Link Conditioner is not included when you install Xcode, but you can download it from Apple. Navigate to the More Tools for Apple Developers page: https://developer.apple.com/download/all/?q=Additional%20Tools. You do not need the paid developer membership to use the tool.

 Select "Additional Tools for Xcode 9.3 and download the .dmg file linked on the right. Then, open the downloaded file and follow the installation instructions.

 Once installed, the network link conditioner will appear as an option in your Mac's preferences.
 
 * better follow YouTube video as per comments on the top. 
 */

//: [Next](@next)
