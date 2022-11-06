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

// 1. Movie Manager Setup - in TMDBClient.swift replace static let apiKey = "YOUR_TMDB_API_KEY" with your API key. Done see TMDBClient.swift, static let apiKey changed from "YOUR_TMDB_API_KEY" to "841622fb8a5a4f75f298f96cb8ba7cd9"

// 2. What is the name of the controller class responsible for presenting the user's favorite movies in The Movie Manager? Hint: Take a look at TMDBClient.swift and the enum used to build URLs. Correct! FavoritesViewController. There's not much going on yet, but you'll use it as you add features to the app.

// 3. Looking at the code for The Movie Manager (or the documentation), what is the base URL for the Movie Database API? (The "base URL" is the URL in which endpoints are added to make specific requests). Correct, in TMDBClient.swift, the Endpoints enum is used to build URLs. The base URL is https://api.themoviedb.org/3

// 4. Run the starter project for the Movie Manager and tap the login button. If you switch to the watchlist tab, why aren't any movies listed? No wrong answer, my try: "because no JSON was added yet to the app". Udacity: One reason is that we don't know which user's watchlist to retrieve. The user also needs to authenticate in order to see their watchlist, but there is currently no authentication in the app.



