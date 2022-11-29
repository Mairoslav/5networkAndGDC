//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

// MARK: 5. Enable and Disable UI Appropriately
// LoginViewController.swift

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
    
    func handleSessionResponse(success:Bool, error: Error?) {
        setLoggingIn(false)
        if success {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
        }
    }
    
    // 00:28 So, "setLogginIn" method is a good place to configure views: Email text Field, Password text Field, Login Button, Login via Website Button.
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
            // emailTextField.isEnabled = false *
        } else {
            DispatchQueue.main.async {
            self.activityIndicator.stopAnimating() // NEW: Error: "UIActivityIndicatorView.stopAnimating() must be used from main thread only", so added async()
            // emailTextField.isEnabled = true *
            }
        }
        // NEW: after re-inserting email/password/button there is Error: "xyz.isEnabled must be used from main thread only", so added async()
        DispatchQueue.main.async() { [self] in // Capture 'self' explicitly to enable implicit 'self' in this closure
            // 00:32 We'll start with the email text fields property, and we know to enable and disable a view we use the property calls isEnabled. The Boolean "_ loggingIn: Bool" will be true if the user is login in. But we want .isEnabled to be false. So we're going to negate it using the ! not operator.
            emailTextField.isEnabled = !loggingIn
            // 00:49 Similarty, if the user is not loggin in, then we want the view to be enabled. So, by negating this value "isEnabled" will then be "true". * Note: this is more effective i.e. less code compared to writing "emailTextField.isEnabled = false"... as per code commented out above. So we follow the same effective way for the other view:
            passwordTextField.isEnabled = !loggingIn
            loginButton.isEnabled = !loggingIn
            loginViaWebsiteButton.isEnabled = !loggingIn
            // 01:03 Again, we're just getting the enabled state from teh "loggingIn" parameter. And we know that because of where we call "setLoggingIn" method, that our buttons and text fields will be enabled and disabled appropriately.
            // Note: this way cannot use below expression, error: "Expression is not assignable: function call returns immutable value"
            // activityIndicator.stopAnimating() = !loggingIn
        }
    }

}


