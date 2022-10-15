//: [Previous](@previous)

import Foundation

/*
 00:00 We just saw how you can convert JSON data to a Dictionary using JSONSerialization so that we can extract individual values. However, what if we had to parse more than one value, like with the host JSON we saw earlier:
 
 {
     "type": "colonial",
     "location": "Plainville, MA",
     "bedrooms": 3,
     "bathrooms": 2.5,
     "hasAirConditioning": false
 }
 
 00:17 We need to get a value for the host "type", "location", "bedrooms"... This is a lot to put in our networking code, which cannot built up quickly. If we wanted to use this data in another part of the app, we could define a model object, such as a struct, to model our host data. However, with JSON serialization, we'd still need to get each value from the dictionary aone at a time before populating the struct the values.
 
 00:44 It would be better for our networking code did not have to know anything about our model objects. Instead, the JSON could be automatically converted into an instance of the host struct.
 
 struct House: Codable {
    let tpe: Strig
    let location: String
    let bedrooms: Int
    let bathrooms: Double
    let hasAirConditioning: Bool
 }
 
 Swift provides a way to do just that with two protocols:
        
        1. Encodable - let's us convert an instance of a model object into a JSON objects ~ FROM SWIFT OBJECT TO JSON
        2. Decodable - converts a JSON object into an instance of our model object ~ FROM JSON TO SWIFT OBJECT
 
 Together, these two make up the protocol MARK: Codable
 
 A class or struct that conforms to the codable protocol can be:
        - converted into JSON data (Encodable),
        - or an instance can be created from JSON data (Decodable).
 
 01:29 If fact, codable even lets you convert between Swift types and other formats, such as XML or with your own custom type, making it versatile for working with different types of data.
 
 01:38 Here, we want to convert a JSON response from the API, into something usable in Swift. So, we're going to decode the JSON using the Swift class JSONDecoder. 
 */

//: [Next](@next)
