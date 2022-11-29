//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

// MARK: 4. Code Review: Show Network Activity
// LoginViewController.swift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    // 02:40 To access "Activity Indicator" from our view controller, we need to add an element from the "assistant editor". Just like any other view, I'll scroll up to where my other outlets are located and drag it to the "LoginViewController.swift" i.e. click + control + drag there (thaks to opening Assistant Editor - having two windows next to each other. I'll call this outlet "activityIndicator".
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        // 03:47 We want the activity indicator to start animating when the login process begins. So here in "logginTapped", I am going to call "setLogginIn, passing in true
        setLoggingIn(true)
        TMDBClient.getRequestToken(completion: handleRequestTokenResponse(success:error:))
    }
 
    @IBAction func loginViaWebsiteTapped() {
        // 03:53 and we'll do the same thing for when we're loggin in via the website
        setLoggingIn(true)
        TMDBClient.getRequestToken { (success, error) in
            if success {
                    UIApplication.shared.open(TMDBClient.Endpoints.webAuth.url, options: [:], completionHandler: nil)
            }
        }
    }
    
    func handleRequestTokenResponse (success: Bool, error: Error?) {
        if success {
            print(TMDBClient.Auth.requestToken)
                TMDBClient.login(username: self.emailTextField.text ?? "nil", password: self.passwordTextField.text ?? "nil", completion: self.handleLoginResponse(success:Error:))
        }
    }
    
    func handleLoginResponse(success: Bool, Error: Error?) {
        print(TMDBClient.Auth.requestToken)
        if success {
            TMDBClient.createSessionId(completion: handleSessionResponse(success:error:))
        } else {
            // NEW: to enable buttons again to try another username and password to get login information correct
            setLoggingIn(false)
        }
    }
    
    // 03:59 When the logging finishes and we  finally have the session ID, we want our activity indicator to stop animating. So here in "handleSessionResponse", I am going to call "setLogginIn" and passing in false for our Boolean parameter.
    // 04:13 Now, if you run the app and try to log in while low speed internet, you'll see the activity indicator was spinning and now we're taken to the tabbed view. Tapping the log out button returns to the "LoginViewController", and because you can see we have finished loggin in as no longer need to access the network, the activity indicator is no longer spinning.
    func handleSessionResponse(success:Bool, error: Error?) {
        setLoggingIn(false)
        if success {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
        }
    
    }
    
    // 02:55  Our next task is to determine where to start and stop the spinning animation on the activity  indicator, and that depends on whether or not the usr is logging in.
    // 03:11 I am going to integrate a new helper function called "setLoggingIn", so that we can uπdate the UI appropriately when the user is logging in. It will take a single Boolean parameter "_ loggingIn: Bool" which will be ture if we're currently loggin in and false if we're not.
    func setLoggingIn(_ loggingIn: Bool) {
        // 03:26 If we are loggin in, that means we're accessing the network, so we want to signal network activity. So I am going to call:
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
        // 03:36 However, for not loggin in, we're not accessing the network at all. So here in the else case, I'll call:
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating() // NEW: Error: "UIActivityIndicatorView.stopAnimating() must be used from main thread only", so added async()
            }
        }
    }
    // 03:47 We want the activity indicator to start animating when the login process begins. So here in "logginTapped" ... move there
}


