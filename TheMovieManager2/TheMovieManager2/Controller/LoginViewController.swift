//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    // 02:35 Finally, we need to call the method to actually get the requestToken. We'll do this in the "LoginViewController.swift", moving there ... yeah here I am. This below is the 1st step in the login process.
    
    @IBAction func loginTapped(_ sender: UIButton) {
        // 02:46 So instead o immediately sequeing to the next screen like we do here line below, we comment it out and replace this code with a call to our method to get the requestToken. Use either a closure or create a helper method to handle the response. We do not do anything else with the completion handler yet, still I'd suggest you check if the request was successful or not, and print out the requestToken to ensure everything worked. There's a lot of steps for making the request, but each one is just like what you did in the RanDob app. The steps needed to get the requestToken are below/incorporated in code and marked in bolt, and if you get stuck go onto the next video to see my solution. There will be plenty of practice making requests like this as we continue to build up the Movie Manager.
        // performSegue(withIdentifier: "completeLogin", sender: nil)
        // MARK: 04:03 Then instead of directly segue when Login button is tapped, I'll call TMDBClient.getRequestToken, passing in the "handleRequestTokenResponse" method that we created. Let's run it to see what we've got. I've entered the username and password for my movie database account, and when I tap Login, we no longer go directly to the tabbed view. Instead, if we look in the console, we see this long String our requestToken printed out. That's exactly what we want.
        TMDBClient.getRequestToken(completion: handleRequestTokenResponse(success:error:)) // MARK: 6. TODO Call the "TMDBClient.getRequestToken" in the "loginTapped()" function in "LoginViewController"
    }
    
    @IBAction func loginViaWebsiteTapped() {
        performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
    // MARK: 03:18 and will do that in the Auth struct, setting the requestToken property to the response objects requestToken. Cool, so we have our new network request. Let's update the LoginViewController.swift to create the requestToken, move there...yeah I am here.
    // MARK: Like in the RanDog App, I am going to create a function to handle the response as this makes our code more readable. It will be called "handleRequestTokenResponse"
    // MARK: 03:45 And it will take a Boolean for whether or not the request was successful, and an optional error. These are the same parameters as the completion handler for the "getRequestToken" method back in TMDBClient.swift
    func handleRequestTokenResponse (success: Bool, error: Error?) {
        // MARK: 03:55 If our request was successful, I'll print out the requestToken from TMDBClient.
        // MARK: 04:03 Then instead of directly segue when Login button is tapped, I'll call... move to body of @IBAction func loginTapped...
        if success {
            print(TMDBClient.Auth.requestToken) // MARK: 7. TODO Use a trailing closure, or function as the completion handler and print "TMDBClient.Auth.requestToken" to verify the result.
        }
    }
}

// TODO: Now that you have the necessary information from the documentation, perform the following steps in The Movie Manager to get the request token - doing this in Xcode project "TheMovieManager2".

// 1. Add a new case to the endpoints enum called "getRequestToken" ...CONTINUE HERE DOING THIS TASK AS PER VIDEO...

// 2. Add a case to the "switch" statement for "stringValue". Build the URL from the base URL, the Endpoint, and the API key query parameter.

// 3. Create a "Codable" struct in "RequestTokenResponse.swift" to model the response with an appropriate "CodingKeys" enum.

// 4. Add a "class func" to "TMDBClint" to get the request token. use the "getRequestToken" case as the URL. The completion handler should pass back two values, a "Bool", and an "Error?". Pass in "true" if parsing (getting the request token succeeds), otherwise pass in "false". Use the "getWatchlist" method as a guide.

// 5. In your "getRequestToken" method, if the token is successfully created, set "Auth.requestToken" to the request token.

// 6. Call the "TMDBClient.getRequestToken" in the "loginTapped()" function in "LoginViewController"

// 7. Use a trailing closure, or function as the completion handler and print "TMDBClient.Auth.requestToken" to verify the result.

