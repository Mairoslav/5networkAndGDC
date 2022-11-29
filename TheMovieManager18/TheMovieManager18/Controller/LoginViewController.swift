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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        setLoggingIn(true)
        TMDBClient.getRequestToken(completion: handleRequestTokenResponse(success:error:))
    }
 
    @IBAction func loginViaWebsiteTapped() {
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
        } else {
            // 04:02 If success is FALSE, then an error occurred. So in the else case, we can call "showLoginFailure" passing in error.localizedDescription making sure it's not nil thanks to expression ? "".
            // MARK: 4.1 Also remember to change our apiKey to just an empty String within "TMDBClient.swift"
            // 04:15 Now before we run it, notice how I've changed our API key to just an empty String within "TMDBClient.swift" ... move there ... 
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func handleLoginResponse(success: Bool, Error: Error?) {
        print(TMDBClient.Auth.requestToken)
        if success {
            TMDBClient.createSessionId(completion: handleSessionResponse(success:error:))
        }
    }
    
    func handleSessionResponse(success:Bool, error: Error?) {
        setLoggingIn(false)
        if success {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
        }
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        loginViaWebsiteButton.isEnabled = !loggingIn
    }
    
    // MARK: recap 4. Alert user (update UI) - and we use this error to present an alert in login view controller letting user know that an error occured.
    // 03:36 Great, so now after work in "TMDBClient.swift" & " TMDBResponse.swift" we have an error with a localized description passed back to our view controller. Let's use it to update the UI. Here in the "LoginViewController.swift" we hav a little convenience method to display an alert controller giving an error message (see the parameter name). Let's use this to tell the user what went wrong.
    // 03:55 We've only modified "taskForGETRequest" so we'll start in the "handleRequestTokenResponse" method, which is the completion handler for a GET request. ... move to "handleRequestTokenResponse" method (4th method above) ...
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "OooNo, Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Okey", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }

}


