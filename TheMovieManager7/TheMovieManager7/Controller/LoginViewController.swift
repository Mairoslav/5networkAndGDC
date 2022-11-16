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
        TMDBClient.getRequestToken(completion: handleRequestTokenResponse(success:error:))
    }
 
    @IBAction func loginViaWebsiteTapped() {
        TMDBClient.getRequestToken { (success, error) in
            if success {
                // 03:20 Then in "LoginViewController.swift" I can remove the call to async here, see it commented out. As well as the call to async in "handleRequestTokenResponse" below
               //  DispatchQueue.main.async {
                    UIApplication.shared.open(TMDBClient.Endpoints.webAuth.url, options: [:], completionHandler: nil)
               //  }
            }
        }
    }
    
    func handleRequestTokenResponse (success: Bool, error: Error?) {
        if success {
            print(TMDBClient.Auth.requestToken)
            // 03:26 As well as the call to async in "handleRequestTokenResponse", see it commented out. We also have ...
            // DispatchQueue.main.async {
                TMDBClient.login(username: self.emailTextField.text ?? "nil", password: self.passwordTextField.text ?? "nil", completion: self.handleLoginResponse(success:Error:))
            // }
        }
    }
    
    func handleLoginResponse(success: Bool, Error: Error?) {
        print(TMDBClient.Auth.requestToken)
        if success {
            TMDBClient.createSessionId(completion: handleSessionResponse(success:error:))
        }
    }
    
    // 03:32 We also have a call to async in "handleSessionResponse", but we cannot remove that yet. That's because cteating the session ID is a "POST" request which we still have to refactor. Now it is a task for you. 
    func handleSessionResponse(success:Bool, error: Error?) {
        if success {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
            }
        }
    }
}
