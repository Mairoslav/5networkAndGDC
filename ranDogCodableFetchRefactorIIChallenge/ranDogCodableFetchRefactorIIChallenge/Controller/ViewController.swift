//
//  ViewController.swift
//  ranDog
//
//  Created by mairo on 28/09/2022.
//

import UIKit

// MARK: QUIZ from 15. Chaining Requests Refactor Part 2

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func pressAndLoadImage(_ sender: Any) {
        
        // TODO: step5: Update the ViewController so that it calls the helper method instead of performing the network call.
        // 02:15 In our ViewController, let's replace our network call (i.e. taskOne that we moved to DogAPI) with a call to  DogAPI.requestRandomImage with the appropriate completionHandler which does parse back the imageData and an error and,
        // 02:34 and it contains this part of code to build the URL and download the image ~ part of taskOne that we did not move to DogAPI ###
        // 02:36 The only difference is that because we pass back an optinal for imageData, we need to safely unwrap it, passing in an empty String if message is nil.
        
        // 03:22 Then finally, up here,  we'll pass in handlerandomImageresponse as our competionHandler and that should do it.
        // DogAPI.requestRandomImage(completionHandler: <#T##(DogImage?, Error?) -> Void#>) // instead of this
        DogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(imageData:error:)) // this
        
    }
         // below part moved to class func requestRandomImage in Model
         /*
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
             
             /*  // but why without this part? Check the response via comment marked ### in time 02:34
             guard let imageUrl = URL(string: imageData.message) else {
                  print("cannot create URL from given String defined under constant imageLocation")
                  return
             } */
              
         }
        
         taskOne.resume()
         */
    
    // TODO: step5: Update the ViewController so that it calls the helper method instead of performing the network call.
    // TODO: step6: Create a helper method in the ViewController called "handleRandomImageResponse". The parameters should match "requestRadomImage's" completionHander and the method should call "requestImageFile". Update the call to "requestRandomImage" to use this method as its completion handler.
    // 02:53 We're almost there, but our code is stil chaining mutiple requests together. The last step is to turn this completionHandler into a separate function. I am going to add new method called "handleRandomImageResponse"
    // 03:16 Here we move our call to request image file into this method. Note ### this is actually the part of  taskOne that we did not move to DogAPI ###
        
    func handleRandomImageResponse(imageData: DogImage?, error: Error?) {
        
        guard let imageUrl =  URL(string: imageData?.message ?? "") else {
            return
        }
        
        DogAPI.requestImageFile(imageUrl: imageUrl, completionHandler: self.HandleImageFileResponse(image:error:))
        
    }
        
    func HandleImageFileResponse(image: UIImage?, error: Error?) {
        
        DispatchQueue.main.async {
            self.imageView.image = image
        }
        
    }
    
}

// 03:37 we successfully refactored our networking code out of the ViewController without breaking the functionality of our app. Let's run our app one more time to see. There we have it. We get a random DogImage as we expect and the code is much cleaner. Not only have we avoided the dreaded pyramid of doom, moreover made our code fit with MVC design principles. While you may not se the difference just yet, separating our neworking code from the ViewController will make it much easier to add new features to our app annd that's just what we'll do in the next lesson.
    
    
// MARK: QUIZ from 15. Chaining Requests Refactor Part 2

/*
 Now it's your turn! Using the same approach as the previous video, refactor the request for a random dog Image URL into a separate method.
 
    // step1: Create a method in DogAPI.swift file called "requestRandomImage"
 
    // step2: Add a "completionHandler" parameter that returns a "DogImage?" and and "Error?"
 
    // step3: Move the networking and JSON parsing code from the ViewController to the "requestRandomImage" method. remember to add "task.resume()"
 
    // step4: Call the "completionHandler" appropriately for when the task succeeds or fails.
 
    // step5: Update the ViewController so that it calls the helper method instead of performing the network call.
 
    // step6: Create a helper method in the ViewController called "handleRandomImageResponse". The parameters should match "requestRadomImage's" completionHander and the method should call "requestImageFile". Update the call to "requestRandomImage" to use this method as its completion handler.
 */
