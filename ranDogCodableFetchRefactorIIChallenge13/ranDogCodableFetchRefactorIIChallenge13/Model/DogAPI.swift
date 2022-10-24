//
//  DogAPI.swift
//  ranDog
//
//  Created by mairo on 29/09/2022.
//

// MARK: 13. Filter By Breed

import Foundation
import UIKit

class DogAPI {
    
    enum Endpoint { // : String { // 01:02 So I am going to remove String here ***
        
        case randomImageFromAllDogsCollection // = "https://dog.ceo/api/breeds/image/random"
        
        // 00:24 I'll add a new "case" and we'll call it "randomImageForBreed" equal to the URL which we can copy from the documentation - note had to adjust it because in newer version what breed is randomly passed in is not visible in link, only is displayed as image. As a breed I limit it to randomimages within "malinois" breed.
        // 00:35 Now this works. But keep in mind that it can only fetch the images of a malinois. What we really wannt is to construct a URL for any breed that we give it. This is a lot like what you may have seen associated values used for. We have enum cases that given some information can generate their values. In this case, we'd supply a breed and use String interpolation to build the URL. Even with/so associated values cannot have a raw value.
        // 01:02 So I am going to remove String here *** (after enum Endpoint), instead let's create a computed property. I'll call it stringValue, see few lines below.
        case randomImageForBreed(String) // = "https://dog.ceo/api/breed/malinois/images/random" // new, adding (String) after "randomImageForBreed"
        // 01:45 Like before, instead of specifying the URL up here (now " = "https://dog.ceo/api/breed/malinois/images/random" commented out ), let's return it from our enum case.
        
        var url: URL {
            // 02:07 Finally, since the raw value was no longer a String, we need to update the URL property to convert "self.stringValue" into the URL, and there we go.
            // return URL(string: self.rawValue)! // commented out
            return URL(string: self.stringValue)!
        }
           
        // 01:02 So I am going to remove String here *** (after enum Endpoint), instead let's create a computed property. I'll call it stringValue. We'll switch on self which is whatever the enum case happens to be.
        // 01:16 Now instead of specifying the URL from "randomImageFromAllDogsCollection" let's handle that specific case and we can return the URL.
        var stringValue: String {
            switch self {
                case .randomImageFromAllDogsCollection:
                    return "https://dog.ceo/api/breeds/image/random"
                
                // 01:25 Now for "randomImageForBreed" this is where using the associated value comes in. We can specify a parameter of type String - (adding (String) after "randomImageForBreed"). This String is going to be the dog breed.
                // 01:36 Now we'll add a case for random image for breed and place let breed inside the parentheses.
                case .randomImageForBreed(let breed):
                    // 01:45 Like before, instead of specifying the URL up in case randomImageForBreed(String)... see few lines above, let's return it from our enum case.
                    // 01:50 Now this URL is still stacit with "malinois as the breed. But whenever we use this enum case, we need to specify a String which is the breed to fetch. So using String interpolation, instead of the "malinois" let's pass in the breed.
                    return "https://dog.ceo/api/breed/\(breed)/images/random"
            }
        }
        
    }
    // 02:18 We have a way to generate the randomImage URL that takes a dog breed as part of the path. Now you certainly don't have to build the URLs in this way, but using associated values you can generate URLs based on some value like a dog breed without making a case for each URL and that makes your code much more readable.
    // 02:38 Let's modify our image request to use the new "randomImageForBreed" URL. Here in func "requestRandomImage" we will add a String parameter called "breed" and instead of fetching a random image for all breeds i.e. "randomImageFromAllDogsCollection", let's use "randomImageForBreed" case, passing in the "breed" as the associated value.
    // class func requestRandomImage(completionHandler: @escaping (DogImage?, Error?) -> Void) {
    class func requestRandomImage(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void) { // breed: String was added
        
        // let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url // commented out
        let randomImageEndpoint = DogAPI.Endpoint.randomImageForBreed(breed).url // new
        // 02:57 All right. So we're almost done. We just need to modify where we can call this method to provide the breed. In didSelectRow and component let's ... (switch to ViewController.swift file)
        let taskOne = URLSession.shared.dataTask(with: randomImageEndpoint) { (dataOne, response, error) in
            guard let dataOne = dataOne else {
                completionHandler(nil, error)
                print("under dataOne there are no data")
                return
            }
            
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: dataOne)
            print(imageData)
            
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

