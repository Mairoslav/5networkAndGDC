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
        /// performSegue(withIdentifier: "completeLogin", sender: nil)
        /// MARK: 6. TODO: Call the "TMDBClient.getRequestToken" in the "loginTapped()" function in "LoginViewController.swift". So, instead o immediately sequeing to the next screen like we do here line above, we comment it out and replace this code with a call to our method to get the requestToken. Use either a closure or create a helper method to handle the response.
        TMDBClient.getRequestToken(completion: handleRequestTokenResponse(success:error:))
    }
    
    @IBAction func loginViaWebsiteTapped() {
        performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
    func handleRequestTokenResponse (success: Bool, error: Error?) {
        if success {
            print(TMDBClient.Auth.requestToken) /// MARK: 7. TODO Use a trailing closure, or function as the completion handler and print "TMDBClient.Auth.requestToken" to verify the result.
            /// 05:50 Now, because this is the second step of the authentication flow, we should call this after the first step completes. So, in the if block of previous func "handleRequestTokenResponse", if the previous request succeeds, we can call TMDBClient.login(username: ...
            /// 06:04 The username comes from the contents of the email text field up here (in @IBOutlet weak var emailTextField: UITextField!). So I'll pass in emailTextField.text and after ?? just pass in empty String if the text is nil. And we do the same thing for the passwordTextField.
            /// 06:22 THe completion handler is the handleLoginResponse method we just created at the bottom. And because we're accessing these UI elements on a completion handler that might be called in the background, we need to wrap this in a call to async (otherwise error: "UITextField.text must be used from main thread only"), adding the self keyword when we're accessing global properties i.e. self.emailTextField.text..., the same for passwordTextField.text and func handleLoginResponse that is in completion handler.
            DispatchQueue.main.async {
                TMDBClient.login(username: self.emailTextField.text ?? "nil", password: self.passwordTextField.text ?? "nil", completion: self.handleLoginResponse(success:Error:))
            }
            /// 06:39 That's everything for the step 2, let's run the app to see it in action. When I tap the Login button / or write in username & password and tap the Login button, I can now see two request tokens printed out. So we are one step closer to authenticating the user.
            /// 06:52 We created a request token and validated it with login information. There is one more thing we need to do, and that is to create a session ID. Thankfully, all we need is one more POST request.
        }
    }
    
    /// 05:22 That's a lot of code but it's nearly identical to what we have already written for the GET reqeust. We just have a few extra steps to make the request. Back here in "LoginViewController.swift", let's call our request to validate the requestToken.
    /// 05:35 Like before, I'll call this  handleLoginResponse, which takes the same parameters as the completion handler, Bool and an Error.
    func handleLoginResponse(success: Bool, Error: Error?) {
        /// 05:45 I'll print the new request token stored in the Auth struct if this request is successful.
        print(TMDBClient.Auth.requestToken)
        /// 05:50 Now, because this is the second step of the authentication flow, we should call this after the first step completes. So, in the if block of previous func "handleRequestTokenResponse"... move up there
        // 02:28 As we call the "createSessionId" method, (now here in the body of above method...), if the requestToken is validated successfully.
        if success {
            // 02:34 For the completion handler, let's pass in the "handleSessionResponse" method we have just created down below. 02:41 Finally in "handleSessionResponse" method ... move there
            TMDBClient.createSessionId(completion: handleLoginResponse(success:Error:))
        }
    }
    // TODO: 9. In "LoginViewController.swift" add a "handleSessionResponse" method that takes a "Bool" and an "Error?" as parameters.
    // 02:18 Let's call method "createSessionId" back here in the "LoginViewController.swift". Again, I'll create a separate method to serve as the completion handler, and call it "handleSessionResponse", taking a Bool and optional error as parameters.
    func handleSessionResponse(success:Bool, error: Error?) {
        // 02:28 As we call the "createSessionId" method, now moving to the body of above method...
        // 02:41 Finally in "handleSessionResponse" method, we check if the request was successful.
        if success {
            // 02:46 And if so, we can complete the login by segueing to the next screen. Again, this will be wrapped in a call to async and we use self because we're in closure (not global scope). That's because performing the segue is supposed to happen on the "main-thread".
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
            }
            // 02:58 Let's run the app and see the completed authentication flow in action. After runnint, I have entered my username and the password. And after tapping Login, I am taken to the Tabbed View. If I click the Watchlist Tab in the down-middle, look at that, I can see a list of movies.
            // 03:20 you have just used your knowledge of GET and POST requests to go through the first authenticatioin flow for the Movie Database. And now that we have the session ID, we're able to start integrating more account features into the Movie Manager app.
        }
        
    }
}
