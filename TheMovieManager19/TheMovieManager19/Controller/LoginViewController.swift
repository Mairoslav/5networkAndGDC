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
                TMDBClient.login(username: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: self.handleLoginResponse(success:error:)) /// changed from Error to error
        } else {
            // 04:02 If success is FALSE, then an error occurred. So in the else case, we can call "showLoginFailure" passing in error.localizedDescription making sure it's not nil thanks to expression ?? "".
            // MARK: 4.1 Also remember to change our apiKey to just an empty String within "TMDBClient.swift" - Not apply this any more.
            // 04:15 Now before we run it, notice how I've changed our API key to just an empty String within "TMDBClient.swift" - not apply this any more ... move there ...
            showLoginFailure(message: error?.localizedDescription ?? "handleRequestTokenResponse")
        }
    }
    
    /// 00:42 Then in the "LoginViewController.swift", I've handled the errors in the completion handlers for the two POST Requests, in "handleLoginResponse" and  in "handleSessionResponse". Again, everything similar to what we did in "taskForGETRequest, but now if we run the app, you'll get an appropriate error message at any stage of the login process that something went wrong. And this is because we conform to the error protocol on our own custom type.
    func handleLoginResponse(success: Bool, error: Error?) { /// changed from Error to error
        print(TMDBClient.Auth.requestToken)
        if success {
            TMDBClient.createSessionId(completion: handleSessionResponse(success:error:))
        } else { /// new
            showLoginFailure(message: error?.localizedDescription ?? "handleLoginResponse")
        }
    }
    
    func handleSessionResponse(success:Bool, error: Error?) {
        setLoggingIn(false)
        if success {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
        } else { /// new
            showLoginFailure(message: error?.localizedDescription ?? "handleSessionResponse")
        }
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            DispatchQueue.main.async() {
            self.activityIndicator.stopAnimating() // NEW: Error: "UIActivityIndicatorView.stopAnimating() must be used from main thread only", so added async()
            }
        }
        // NEW: after re-inserting email/password/button there is Error: "xyz.isEnabled must be used from main thread only", so added async()
        DispatchQueue.main.async() { [self] in // Capture 'self' explicitly to enable implicit 'self' in this closure, added [self] in
            emailTextField.isEnabled = !loggingIn
            passwordTextField.isEnabled = !loggingIn
            loginButton.isEnabled = !loggingIn
            loginViaWebsiteButton.isEnabled = !loggingIn
        }
    }
    
    // MARK: recap 4. Alert user (update UI) - and we use this error to present an alert in login view controller letting user know that an error occured.
    // 03:36 Great, so now after work in "TMDBClient.swift" & " TMDBResponse.swift" we have an error with a localized description passed back to our view controller. Let's use it to update the UI. Here in the "LoginViewController.swift" we hav a little convenience method to display an alert controller giving an error message (see the parameter name). Let's use this to tell the user what went wrong.
    // 03:55 We've only modified "taskForGETRequest" so we'll start in the "handleRequestTokenResponse" method, which is the completion handler for a GET request. ... move to "handleRequestTokenResponse" method (4th method above) ...
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "OooNo, Login Failed", message: message, preferredStyle: .alert) // NEW: instead writing message now writing directly "Seems like Email or Password are wrong, try again".
        alertVC.addAction(UIAlertAction(title: "Okey", style: .default, handler: nil))
        show(alertVC, sender: nil) // tried changing "sender: nil" to "sender: message"
        setLoggingIn(false) // NEW: so that activity indicator stops rotating and fields are enabled for re-inserting Email/Password
    }

}


