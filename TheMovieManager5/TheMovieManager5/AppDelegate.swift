//
//  AppDelegate.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // 02:23 (from "LoginViewController.swift") Great so our app hands off the task of validating the request token to the browser, we just need to handle the redirectURL. Here in the "AppDelegate.swift" let's override the method to open a URL. If I start typing the name, code completion will fill in the rest (do not get the point here).
    // 02:38 We have a parameter here for the URL that we opened. We need to check if it is the right URL, there are many ways to do this. I find breaking it down into its components to be an easy way to check the URL.
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // 02:49 So we will create a new constant called components equal to URLComponents. We'll initialize this with the URL we just received, and I'll pass in true for resolving against base URL, so entire or absolute URL is used.
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        // 03:05 The URL scheme is the "moviemanager", hence the path is authenticated. That tells us if the URL is in correct format.
        if components?.scheme == "themoviemanager" && components?.path == "authenticate" {
            // 03:12 If so we can continue the login process. There are many ways you can structure the login code in your app and this is specific to just TheMovieManager.
            // 03:23 First we get a reference to our "LoginViewController.swift", which is the root controller of our app.
            let loginVC = window?.rootViewController as! LoginViewController
            // 03:27 Then we simply call TMDBClient.createSessionId(... passing in the loginVC to handle session response method as the completion handler here.
            TMDBClient.createSessionId(completion: loginVC.handleSessionResponse(success:error:))
        }
        // 03:38 Finally, we need to return true from this method to signal that we open the URL successfully.
        return true
    }
    
// 03:45 We could have handled all of this logic in the AppDelegate.swift. But for the sake of convenience, we let the LoginViewController.swift to handle the details. The point is that this only happens after we received the redirect URL, when the requestToken has been authorized by the user, only then can we proceed to the final step in the authentication flow. Let's run it to see what we've got.
    
// 04:04 When I tap the login via Website button, I am taken to a page where I can enter my login information for the movie database. Since I am already logged in, now I see this 3rd party authentication request screen. This prompts me if I want to authenticate with the Movie Manager, I'll tap approve, and this is not what we're expecting.
    
// 04:23 Now it is letting me know that "the address is invalid" (not my case, it all works, why?). Well we did technically specify the URL for our Movie Manager app, but iOS has no idea / no way of knowing what app handles that URL (seems like now new version/s do know, because Xcode is asking me if I want to "open in "TheMovieManager"?").
    
// 04:34 So we know that in order to handle custom incoming URLs, we need to specify them for our app. To do this let's head over to the project settings, click on "TheMovieManager5" project file / Info / URL types (in my case the URL type is alrady there) / I'll click pluss to add a new type / ... check the BOXES to be filled in:
    
/*
 04:54
 The IDENTIFIER: com.udacity.TheMovieManager / is just the bundle ID of the app.
 URL SCHEMES: themoviemanager / set the scheme to match the URL we specified in the code.
 */
    
// 05:00 Let's run the app again to see what happens this time. I'll again tap the login via Website button. I log in / or if I am already logged in I press "Approve" for 3rd party authentication request.
    
// 05:11 This time browser also gives us a pop up, but it asks us if we would like to open this URL in the MovieManager. I'll click open. And I am returned to our app, where we can access the tab view and also the watchlist. But this time, we do not need to handle the login credentials, instead the login is validated on the movies databse server. Not only is this authentication flow popular, it is also useful as you built your own apps. 
    
}

