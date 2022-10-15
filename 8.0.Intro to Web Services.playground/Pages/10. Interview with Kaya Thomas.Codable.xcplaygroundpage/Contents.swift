//: [Previous](@previous)

import Foundation

// MARK: 10. Interview with Kaya Thomas: Codable

/*
 00:17 Hi Caya, can you tell us a little bit about the differences with the newer Codable protocol, and why should we use it in our apps?
 
 00:27 Caya: so the old way to do JSON parsing in iOS was using JSONSerialization. Using that you had to map out all of the keys manually yourself. So, you had to translate all of it into a dictionary, and then know exactly where the keys were and how they mapped out.
 
 00:42 But with the new codable protocol, as long as you create objet that adheres to the protocol ad has all of the properties that directly match to the JSON, Apple will do the work for you.
 
 00:54 Mark: Well, that's sounds good to me. Let's see how we can user the Codable protocol in the runDog app. 
 */

//: [Next](@next)
