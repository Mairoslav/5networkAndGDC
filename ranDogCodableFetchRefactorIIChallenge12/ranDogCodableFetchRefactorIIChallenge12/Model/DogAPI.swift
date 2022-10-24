//
//  DogAPI.swift
//  ranDog
//
//  Created by mairo on 29/09/2022.
//

import Foundation
import UIKit

class DogAPI {
    
    enum Endpoint: String {
        
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
            
    }
    
    // TODO: step1: Create a method in DogAPI.swift file called "requestRandomImage" `~ create a helper method
    // 00:26 Just like the method "requestImageFile", it will take a completionHandler, a closure that return Void or nothing. 00:35 The request returns a JSON response that's parsed into a "DogImage" struct - see DogImage.swift file.
    // 00:40 So the 1st parameter will be of type otpional "DogImage?". As 2nd we'll also pass back the error as optional type Error?. These are both optional. Depending whether or not their request succeeds either "DogImage" or "Error" will have a value and the other one will be nil.
    // 00:58 And remember that becquse the completionHandler will be called after this function has finished executing, it needs to be marked with keybord "@escaping"
    // TODO: step2: Add a "completionHandler" parameter that returns a "DogImage?" and and "Error?" ~ set both parameters included in completionHander
    
    class func requestRandomImage(completionHandler: @escaping (DogImage?, Error?) -> Void) {
        
        // TODO: step3: Move the networking and JSON parsing code from the ViewController to the "requestRandomImage" method. Remember to add "task.resume()"
        // 01:14 Now, let's move on to actually makking the request. Here in the ViewController, we will copy and move all the code from generating the URL (1st line) to performing the reuest and parsing the JSON (last lines). And we'll paste it into the "requestRandomImage" method remembering to add our closing brace.
        // 01:33 We'll also be sure to call task.resume() so that the request actually runs.
        
        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        let taskOne = URLSession.shared.dataTask(with: randomImageEndpoint) { (dataOne, response, error) in
            guard let dataOne = dataOne else {
                
                
                // TODO: step4.1-2.: Call the "completionHandler" appropriately for when the task succeeds or fails
                // 01:39 Now, the other part where we wanted to send data back to the caller, our ViewController, using the completionHandler up here in DogAPI (see requestRandomImage method).
                // This is just like what we do with "requestImageFile" method:
                    // 01:48 if the JSON parsing is cuccessful, we'll pass in the DogImage struct and specify nil for the error.
                    // 01:56 If it's not successful, we will call completionhanler here below, parsing in nil for DogImage and the error we got from the dataTask.
                
                completionHandler(nil, error)
                print("under dataOne there are no data")
                return
            }
            
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: dataOne)
            print(imageData)
            
            /* FIXME: but why without this part? Check the response via comment marked ###
             print(imageData.message)
             
             let imageLocation = imageData.message
             
             guard let imageUrl = URL(string: imageLocation) else {
                 print("cannot create URL from given String defined under constant imageLocation")
                 return
             }
             */
            
            // TODO: step4.1: Call the "completionHandler" appropriately for when the task succeeds or fails
            // 01:48 if the JSON parsing is cuccessful, we'll pass in the DogImage struct and specify nil for the error.
            
            completionHandler(imageData, nil)
            
        }
        
        taskOne.resume()
        
    }
    
    class func requestImageFile(imageUrl: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        
        let taskTwo = URLSession.shared.dataTask(with: imageUrl) {
            (dataTwo, response, error) in
            
            guard let dataTwo = dataTwo else {
                completionHandler(nil, error)
                print("under dataTwo there are no data")
                return
            }
            
        let downloadedImage = UIImage(data: dataTwo)
        
        completionHandler(downloadedImage, nil)
            
        }
        
        taskTwo.resume()
        
    }
    
}

// 02:06 So now as we've moved to networking code from the ViewControlle to the DogAPI class, let's update the ViewController to call our new method. Yes now switch to ViewController. 
