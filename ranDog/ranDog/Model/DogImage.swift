//
//  DogImage.swift
//  ranDog
//
//  Created by mairo on 01/10/2022.
//

// MARK: 12. From JSON to Struct with Codable

import Foundation

// 00:20 First off, let's create a new swift file under the model group and call it DogImage.swift.
// 00:28 As we'll define a struct called DogImage, the successful response we get from the DogAPI consists of two values: status and message, both being of String type. A String containing the URL of the DogImage.
// 00:45 To convert JSON into an instance of our struct, DogImage will need to conform to the Codable protocol. Let's add that up here. 

struct DogImage: Codable {
    let status: String
    let message: String
}
