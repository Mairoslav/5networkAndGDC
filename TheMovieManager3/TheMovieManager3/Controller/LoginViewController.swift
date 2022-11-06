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
    
    @IBAction func loginTapped(_ sender: UIButton) {
        // performSegue(withIdentifier: "completeLogin", sender: nil)
        // MARK: 6. TODO: Call the "TMDBClient.getRequestToken" in the "loginTapped()" function in "LoginViewController.swift". So, instead o immediately sequeing to the next screen like we do here line above, we comment it out and replace this code with a call to our method to get the requestToken. Use either a closure or create a helper method to handle the response.
        TMDBClient.getRequestToken(completion: handleRequestTokenResponse(success:error:))
    }
    
    @IBAction func loginViaWebsiteTapped() {
        performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
    func handleRequestTokenResponse (success: Bool, error: Error?) {
        if success {
            print(TMDBClient.Auth.requestToken) // MARK: 7. TODO Use a trailing closure, or function as the completion handler and print "TMDBClient.Auth.requestToken" to verify the result.
            // 05:50 Now, because this is the second step of the authentication flow, we should call this after the first step completes. So, in the if block of previous func "handleRequestTokenResponse", if the previous request succeeds, we can call TMDBClient.login(username: ...
            // 06:04 The username comes from the contents of the email text field up here (in @IBOutlet weak var emailTextField: UITextField!). So I'll pass in emailTextField.text and after ?? just pass in empty String if the text is nil. And we do the same thing for the passwordTextField.
            // 06:22 THe completion handler is the handleLoginResponse method we just created at the bottom. And because we're accessing these UI elements on a completion handler that might be called in the background, we need to wrap this in a call to async (otherwise error: "UITextField.text must be used from main thread only"), adding the self keyword when we're accessing global properties i.e. self.emailTextField.text..., the same for passwordTextField.text and func handleLoginResponse that is in completion handler.
            DispatchQueue.main.async {
                TMDBClient.login(username: self.emailTextField.text ?? "nil", password: self.passwordTextField.text ?? "nil", completion: self.handleLoginResponse(success:Error:))
            }
            // 06:39 That's everything for the step 2, let's run the app to see it in action. When I tap the Login button / or write in username & password and tap the Login button, I can now see two request tokens printed out. So we are one step closer to authenticating the user.
            // 06:52 We created a request token and validated it with login information. There is one more thing we need to do, and that is to create a session ID. Thankfully, all we need is one more POST request.
        }
    }
    
    // 05:22 That's a lot of code but it's nearly identical to what we have already written for the GET reqeust. We just have a few extra steps to make the request. Back here in "LoginViewController.swift", let's call our request to validate the requestToken.
    // 05:35 Like before, I'll call this  handleLoginResponse, which takes the same parameters as the completion handler, Bool and an Error.
    func handleLoginResponse(success: Bool, Error: Error?) {
        // 05:45 I'll print the new request token stored in the Auth struct if this request is successful.
        print(TMDBClient.Auth.requestToken)
        // 05:50 Now, because this is the second step of the authentication flow, we should call this after the first step completes. So, in the if block of previous func "handleRequestTokenResponse"... move up there
    }
}
