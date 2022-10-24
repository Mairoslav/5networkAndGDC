//
//  BreedsListResponse.swift
//  ranDogCodableFetchRefactorIIChallenge14
//
//  Created by mairo on 24/10/2022.
//

import Foundation

// 2e.II. 02:33 To keep our project organized, I am going to add the struct in a new file but it could work anywhere. Under the Model group, I'll add a new Swift file and I'll call this BreedsListResponse... check it, and I'll add there new struct being called BreedsListResponse making sure it conforms to the Codable protocol as we'll need two properties:
    // 1. "status" which is a String, and
    // 2. "message" which is a dictionary. These dictionary keys are the actual dog breeds. The values are arrays of Strings. We won't actually need to access the values but I'll set the keys type to String and the values to String Array.

struct BreedsListResponse: Codable {
    let status: String
    let message: [String: [String]]
}

// 2f. 03:17 Then back in the API class ... check it
