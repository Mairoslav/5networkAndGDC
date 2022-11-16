//
//  UIViewController+Extension.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // TODO: 7.0 Call the "logout" method in the "logoutTapped" function in "UIViewController+Extension.swift".
    // 01:15 This function is called "logoutTapped". When logging code is complete, we simply dismiss the tabbed view to return to our login screen, using DispatchQueue.main.async to run this on the main thread.
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        // TODO: 8.0 In the completion handler, dismiss the view controller on the main thread.
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
            print("now logged out")
        }
    }
}

// That's all there is to it. With a basic knowdelge of making HTTP requests, we can implement all the steps of the authentication flow, including tha ability to log out.

