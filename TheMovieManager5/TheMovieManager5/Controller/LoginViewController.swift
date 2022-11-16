//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

// MARK: 13. OAuth-like Authentication in the Movie Manager
// as commented in "TheMovieManager5.xcodeproj"

// 00:00 To implement the OAuth login flow in TheMovieManager, all we need to do is to open URL after creating the request token. Once we received the redirect URL we complete the login by requesting the sessionID.

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
    
    @IBAction func loginTapped(_ sender: UIButton) {
        TMDBClient.getRequestToken(completion: handleRequestTokenResponse(success:error:))
    }
    
    // 00:15 Our "LoginViewController.swift" has another button to "Login via Website".
    @IBAction func loginViaWebsiteTapped() {
        // 00:18 Instead of performing the Segue immediately, we need to implement each of the login steps ***. So we comment out below original code:
        // performSegue(withIdentifier: "completeLogin", sender: nil)
        // 00:24 *** Thankfully, these methods already exist from the prior steps, the only difference is tha our app does not need to worry about validating the request token.
        // 00:34 To initiate 1st step in login process see code below. Here using the trailing closure syntax for the completion handler (Control + / + Enter on completion handler to change fro trailing closure), but creating a separate function will work as well.
        TMDBClient.getRequestToken { (success, error) in
            if success {
                // 00:47 If success is true, we have a requestToken. To validate it, we open the URL specified by the documentation. For consistency let's go to the "TMDBClient.swift" an dadd a new case to the Endpoints enum ... move there
                // 01:52 Back in the "LoginViewController.swift", all we need to open the URL is to call "UIApplication.shared.open" (type in "openoptionscompletion" it will pop up) and from TMDBClient we'll pass in the URL we just created from our Endpoint. I'll set the options: to an empty Dictionary, and the completion handler to nil, as we do not need any of these.
                // 02:14 Of course, since we are interacting with the UI (Optioin + click on UIAppliacation and will see "The centralized point of control and coordination for apps running in iOS."), this call also needs to be wrapped in a call to async.
                DispatchQueue.main.async {
                    UIApplication.shared.open(TMDBClient.Endpoints.webAuth.url, options: [:], completionHandler: nil)
                }
                // 02:23 Great so our app hands off the task of validating the request token to the browser, we just need to handle the redirectURL. Here in the "AppDelegate.swift" ... move there
            }
        }
    }
    
    func handleRequestTokenResponse (success: Bool, error: Error?) {
        if success {
            print(TMDBClient.Auth.requestToken)
            DispatchQueue.main.async {
                TMDBClient.login(username: self.emailTextField.text ?? "nil", password: self.passwordTextField.text ?? "nil", completion: self.handleLoginResponse(success:Error:))
            }
        }
    }
    
    func handleLoginResponse(success: Bool, Error: Error?) {
        print(TMDBClient.Auth.requestToken)
        if success {
            TMDBClient.createSessionId(completion: handleSessionResponse(success:error:))
        }
    }
    
    func handleSessionResponse(success:Bool, error: Error?) {
        if success {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
            }
        }
    }
}
