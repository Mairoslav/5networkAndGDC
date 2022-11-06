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
            print(TMDBClient.Auth.requestToken)
            DispatchQueue.main.async {
                TMDBClient.login(username: self.emailTextField.text ?? "nil", password: self.passwordTextField.text ?? "nil", completion: self.handleLoginResponse(success:Error:))
            }
        }
    }
    
    func handleLoginResponse(success: Bool, Error: Error?) {
        print(TMDBClient.Auth.requestToken)
        // 02:28 As we call the "createSessionId" method, (now here in the body of above method...), if the requestToken is validated successfully.
        if success {
            // 02:34 For the completion handler, let's pass in the "handleSessionResponse" method we have just created down below. 02:41 Finally in "handleSessionResponse" method ... move there
            TMDBClient.createSessionId(completion: handleSessionResponse(success:error:))
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
