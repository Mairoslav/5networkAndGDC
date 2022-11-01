//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

// 5. Movie Manager Tour, // 04:14 There are these other view controllers, but we will use these later. the only one thing I want you to look at now is the LoginViewController, move there... // 04:22 In this file, we have some IBActions for our login buttons.

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
    
    // 5. Movie Manager Tour, // 04:22 In this file, we have some IBActions for our login buttons. Right now, these just segue to the rest of the app, but the user is not actually logged in. Again, the Movie Manager is more sophisticated than the apps we have worked with. So take a moment to get familiar with the starter code. I have provided few tasks below the video to complete. Also try running the app and tap the watchlist button to see what happens.
    @IBAction func loginTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
    @IBAction func loginViaWebsiteTapped() {
        performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
}

// MARK: few tasks below the video to complete

// 1. Movie Manager Setup - in TMDBClient.swift replace static let apiKey = "YOUR_TMDB_API_KEY" with your API key. CONTINUE HERE


