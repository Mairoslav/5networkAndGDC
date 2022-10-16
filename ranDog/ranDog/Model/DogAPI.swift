//
//  DogAPI.swift
//  ranDog
//
//  Created by mairo on 29/09/2022.
//

// MARK: 6. Storing the Endpoint

import Foundation

// we create a new class to encapsulate all our code for the Dog API
class DogAPI {
    // We add an enum called Endpoint where each case is an endpoint
    enum Endpoint: String { // 00:55 To get our app running quickly let's store each endpoint as the full URL. So we'll give htis enum a raw value of type String
        // then I can store the first endpoint, and give it a name that reflects how the API refers to it
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        // crate a computed property called URL that we can use to access this endpoint as a URL, which we'll need for making our request. So it will be a variable type URL and we'l use the URL consructor that takes a String parameter to convert self.rawValue into a URL. Since that constructor returns an optional URL, we will need to unwrap it here
        var url: URL {
            return URL(string: self.rawValue)! // what shall I write in case I want to use ?? ?
        }
    }
}
