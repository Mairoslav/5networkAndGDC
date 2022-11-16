//: [Previous](@previous)

import Foundation

// MARK: 12. Working with URLs in iOS Apps
// check also web site https://developers.themoviedb.org/3/authentication/how-do-i-generate-a-session-id

// 00:00 To authenticate via browser, we need to open this URL: https://www.themoviedb.org/authenticate/{REQUEST_TOKEN}

// 00:05 When implementing this type of login flow, we also need a way to redirect back into our app. The TMDB Movie Datablase offers this optional query parameter.

// https://www.themoviedb.org/authenticate/{REQUEST_TOKEN}?redirect_to=http://www.yourapp.com/approved

// 00:15 To redirect URL, we can tell iOS to open this type of URL on TheMovieManager app (i.e. to our/your app). How would this work? Well if you have seen phone numbers or email addresses hyperlinked for instance, clicking them actually takes you to a URL. The URL is not HTTP based like we've already worked with.

// 00:33 For example a phone number would have the tel: protocol and email address would have the mailto: protocol. Our app can intercept/catch these URLs, but we can define our own URL scheme specific to TheMovieManager app. When the browser redirets to this URL, iOS will return to TheMovieManager so we can complete the login.

// 00:54 So to implement the OAuth-like flow, we need to know how to do two things:

    // 1. open a URL in Safari (UIAplication)

    // 2. and handle incoming URLs in our app (UIApplicationDelegate)

// 01:04 To make sure we are on the same page head over to the documentation for UIApplication and UIApplicationDelegate and then answer the following "Reflect" questions 1 & 2 below.

// ............................................................

// MARK: Reflect1 - Look at the documentation for UIApplication. Which method opens a URL in Safari? https://developer.apple.com/documentation/uikit/uiapplication

// Udacity:
/*
 Opening a URL resource - calling the open method will open a URL in Safari:
 func open(URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler: ((Bool) -> Void)?)
 Attempts to asynchronously open the resource at the specified URL.
 */

// MARK: Reflect2 - Look at the documentation for UIApplicationDelegate. Which method handles URLs opened in an app? https://developer.apple.com/documentation/uikit/uiapplicationdelegate

/*
 // Udacity:
 This method can be used to handle incoming URLs: https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623112-application
 // From DeveloperDocumentation:
 Opening a URL-specified resource
 func application(UIApplication, open: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool
 Asks the delegate to open a resource specified by a URL, and provides a dictionary of launch options.
 i.e.: 
 application(_:open:options:)
 Asks the delegate to open a resource specified by a URL, and provides a dictionary of launch options.
 */

//: [Next](@next)
