//
//  ViewController.swift
//  ranDog
//
//  Created by mairo on 28/09/2022.
//

// MARK: 15. Chaining Requests Refactor Part

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressAndLoadImage(_ sender: Any) {
        
        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        
        let taskOne = URLSession.shared.dataTask(with: randomImageEndpoint) {
            (dataOne, response, error) in
            
            guard let dataOne = dataOne else {
                print("under dataOne there are no data")
                return
            }
            
            let decoder = JSONDecoder()
            
            let imageData = try! decoder.decode(DogImage.self, from: dataOne)
            
            print(imageData)
            
            print(imageData.message)
            
            let imageLocation = imageData.message
            
            guard let imageUrl = URL(string: imageLocation) else {
                print("cannot create URL from given String defined under constant imageLocation")
                return
            }
            
            // 00:00 The socond step in refactoring our request to reduce the amount of indenting, is to create a helper method (see few lines below) so that we can get this code that updates the UI out of the completion handler. TODO: 1
            
            // 00:45 Remember, that the functions and closures are one and the same. So we can simplify this code by just passing our function into the completionHandler. So, I'll **** remove the closure we've passed in and I'll pass in "self.handleImageFileResponse(image:error:)", the helper function we declared as new at the bottom. Perfect. Now, if we run our app, we can see that the random dog image is still being loaded. TODO: 4
            
            DogAPI.requestImageFile(imageUrl: imageUrl, completionHandler: self.HandleImageFileResponse(image:error:) // {(image,error) in // ****
                        
            // 00:32.b *** async call moved to body of new helper method "func HandleImageFileResponse"
                                    
            /*
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            */
                                    
            // } // removed as per ****
            )
            
            // taskTwo refactored into our new method in Refactor part 1 already
            
        }
        
        taskOne.resume()
    
    }
    
    //  00:14 I am going to add a new method to our ViewController called HandleImageFileResponse. Like the requestImageFile methods' completionHandler, its completionHandler will take two parameters, one for the image and one for the error. TODO: 2
    
    func HandleImageFileResponse(image: UIImage?, error: Error?) {
        // 00:32.a Inside this method, we'll move our async call that updates the ImageView (we just moved/commented it out from "DogAPI.requestImageFile" see note ***). Again, I am not worried about the error case here since the imageView.iimage property can be set to nil if the call fails (click on image and can see that it can be nil because of ?). TODO: 3
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}

// 01:11 Our code is looking much better now but we still need to refactor the other request, the one that requests a random image URL into the DogAPI class. I am leaving this as a challenge exercise for you to complete. I've created a list of tasks below thhe video that are needed to refactor the request. TODO: 5

