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
    
    // MARK: 15. Chaining Requests Refactor Part 1 - all below is new
    //  01:21 Let's start with the second request, the one that downloads the actual image file. We want the code that performs networks requests to live in the Model(M) group of MVC. So we're going to go into DogAPI.swift file and add a helper method to perform this request. I am going to call this method func requestImageFile. It needs to know which file we're downloading, so it will take a URL as a parameter. This is the URL we got from our previous request, and I am going to mark it as a class method because we don't need an instance of the DogAPI class in order to use it.
    // 01:57 Then from the ViewController, let's copy in our code that makes the network request - see "let taskTwo = URLSession.shared.dataTask(with: imageUrl) {... "
    // 02:13 And of course remember to call task.resume() method.
    
    // 02:16 Now we are at the point where we have the image data and we need to pass it back to our ViewConntroller where our method will be called. 02:23 Remember that we can't return a value from requestImageFile from mwithin data task with request closure. This is where completion handler pattern comes in. Just like dataTask with request, our requestImageFile method can take a closure OR a function as a parameter that we can pass the data to. It's up to the caller or the ViewController in our case, to determine what to do with that data. 02:48 We'll let a completion handler to our function next.
    // 02:51 Here after the URL parameter, let's add another parameter called "completionHandler", and its type is going to be a closure that returnns Void. Remember that a completionHandler will ultimately be called by another function,  possibly after request image file is finished executing, so we'll need to mark it as @escaping. The parameters of the values that will get passed back to our ViewController.
            /// 1. The first one is the image of optional type UIImage
            /// 2. The second is the error of optional type error
    // Our download may fail, so passing the error back to the ViewController allows us to respond accordingly.
    // 03:31 And because we're using UIImage in this file, we also need to import UIKit - see line 9
    // 03:36 This is Okay so long as we're not directly modifying the View from our Model code, but in practice it may be better to not assume that our downloaded data will actually be used as an UIImage.
    // 03:49 Looking back at the completion handler, notice that I marked both of these paramaters as optional. Why is that? Well, we know that if we get image data then an error did not occur. So, the error is nil. However, if the download fails for some reason, we know we're going to have some error, but the image data will not esxist, and should be nil.
    // helper method to perform request, see note above in time 01:21
    class func requestImageFile(imageUrl: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) { // 02:04 vs video here parameter label is "imageUrl:", not "url":, so I can keep below code "let taskTwo = URLSession.shared.dataTask(with: imageUrl) { (dataTwo,..." unchanged, no need to change imageUrl to url
        
        let taskTwo = URLSession.shared.dataTask(with: imageUrl) { // taskTwo cut from ViewController with changes marked, see notes 01:57
            (dataTwo, response, error) in
            guard let dataTwo = dataTwo else {
                // 04:31 The else body of our guard statement is executed when an error occurs. So, we need to call our completion handler here as well. This time no image data is returned, so we pass in nil for the image, and we'll also pass in the error we received from URL session dataTask completion handler.
                completionHandler(nil, error) // new code - call our completion handler here 1st time. TODO: new
                print("under dataTwo there are no data")
                return
            }
        let downloadedImage = UIImage(data: dataTwo)
        //  04:11 Let's handle both the cases when we call our completion handler. Firstly, when the download is successful, we have some image data to pass back to the ViewController. So we're going to call our completion hadler down here, passing in the downloaded image for the image, ands nil for the error.
        completionHandler(downloadedImage, nil) // 04:31 new code - call our completion handler here 2nd time, just switch nils. TODO: new
        // DispatchQueue relocated and kept in ViewController, in the body of  "DogAPI.requestImageFile(imageUrl:..." TODO: new
        }
        taskTwo.resume()
    }
}

// 04:48 So, we're done implementing request image file. Now, it's time to call it from our ViewController. We'll do this once we have the URL by calling DogAPI. request image file. Now switch to ViewController. 
