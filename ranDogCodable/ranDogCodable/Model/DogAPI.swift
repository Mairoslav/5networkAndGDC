//
//  DogAPI.swift
//  ranDog
//
//  Created by mairo on 29/09/2022.
//

// MARK: 6. Storing the Endpoint - see comments in previous version called "ranDog"

import Foundation

class DogAPI {

    enum Endpoint: String {
        
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
        
    }
    
}
