//
//  DogAPI.swift
//  ranDog
//
//  Created by mairo on 29/09/2022.
//

// MARK: 13. Filter By Breed
// MARK: 15. Breeds List Walkthrough

import Foundation
import UIKit

class DogAPI {
    
    enum Endpoint {
        
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        // MARK: 1. Add a URL for the breeds list
        // 1a. 00:32 Add "listAllBreeds" case to the "Endpoints" enum and ...
        case listAllBreeds
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
           
        var stringValue: String { // "stringValue"**
            switch self {
                case .randomImageFromAllDogsCollection:
                    return "https://dog.ceo/api/breeds/image/random"
                case .randomImageForBreed(let breed):
                    return "https://dog.ceo/api/breed/\(breed)/images/random"
                // 1b. and make its "stringValue"** return the correct URL
                case .listAllBreeds:
                    return "https://dog.ceo/api/breeds/list/all"
            }
        }
        
    }
    
    class func requestRandomImage(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void) {
        
        let randomImageEndpoint = DogAPI.Endpoint.randomImageForBreed(breed).url
        
        let taskOne = URLSession.shared.dataTask(with: randomImageEndpoint) {
            (dataOne, response, error) in
            
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
    
    // MARK: 2. Create a method with a completion handler in DogAPI that requests the breedList
    // 2a. 00:31 Now, to make a request to this URL, we also need to add another method to our API class, I'll call this requestBreedsList. Its only parameter will be a completion handler. This will pass back an Array of Strings and an optional error. Like the others, I'll mark it as @escaping and notice the return type is still Void.
    class func requestBreedsList(completionHandler: @escaping ([String], Error?) -> Void) {
        
        // 2b. 00:54 Now to make the request, we'll create a new task using the shared URL session. Calling dataTask will pass in the listAllBreeds URL. And we'll get back data, response, and en error.
        let taskThree = URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url) {
            (dataThree, response, error) in
            
            // 2c. 01:11 The first thing we do in the body of the completion handler is check to make sure we got data back using a guard statement. We'll call the completionHandler, passing in an empty Array meaning we did't get any dog breeds, hence the error if something went wrong. We then need to return from the closure. But if the request was successful, we'll continue on it parsed the data. This is exactly like we do for the other methods, and you're probably starting to notice thhat a lot of this code is the same.
            guard let dataThree = dataThree else {
                completionHandler([], error)
                print("under dataThree there are no data")
                return
            }
            
            // 2f. 03:17 Then back in the API class, once we know we got data from the server we can parse the JSON. I'll create a new JSON decoder. And will parse it into a constant called breedsResponse. Passing in breedsListResponse as the type to parse into as well as the data we're trying to parse. Assuming our JSON is valid, we can disable error propagation with try, but you're welcome to handle it using a do-catch.
            let decoder = JSONDecoder()
            let breedsResponse = try! decoder.decode(BreedsListResponse.self, from: dataThree)
            
            // 2g. 03:45 Now that we have the responses' usable Swift type and we know the keys of the message property or the dog breeds we want, let's convert the keys propety to an Array of Strings. We can do this by mapping over the keys.
            let breeds = breedsResponse.message.keys.map({$0})
            // 2h. 03:58 Finally, we can call the completion handler passing in the breeds and nil for the error. So that's the code for making the request. Now let's head over to the ViewController to call it. Check ViewController.swift. 
            completionHandler(breeds, nil)
            
        }
        // 2d. 01:38 The one other thing we need to do for every network request is to call taskThree.resume(). This ensures that our request actually gets executed. 
        taskThree.resume()
        
    }
    
}

// 2e.I. 01:48 All right, so to actually parse theh JSON, let's take one more look at the documentation: https://dog.ceo/dog-api/documentation/ checking "List all breeds" window. The response is a JSON object with a String property called "status" with a value of "success". And in this "message" property, we have another JSON object. So, we're going to need our knowledge of nested JSON objects in order to parse this. If you look at the contents of this JSON object, we can see that each of the breeds are keys. Our app doesn't know these keys in advance, so to access them, we can use a dictionary like we did before. We're only concerned with the list of breeds and the rest of this data we actually do not need. So, I think we're all st on how to parse this. Let's go back into Xcode and do that now.
// 2e.II. 02:33 To keep our project organized, I am going to add the struct in a new file but it could work anywhere. Under the Model group, I'll add a new Swift file and I'll call this BreedsListResponse... check it

