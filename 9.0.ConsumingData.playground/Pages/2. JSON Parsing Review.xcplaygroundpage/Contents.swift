// import UIKit

// MARK: 2. JSON Parsing Review

/*
 00:00 As you'll be working with JSON a lot during this lesson, let's take a moment to review what we know about JSON parsing in Swift. Here I provided a simple JSON object for a platen with a few different properties. Your task will be to:

    // 1. create a struct called "Planet" that conforms to Codable protocol ~ create a struct to represent this JSON object in Swift
 
    // 2. the struct should have properties with matching names and data types to the JSON ~ using properties of the corret datatype,
 
    // 3. create a JSON decoder ~ and as per step 1. the struct should conform to the codable protocol, using a JSON decoder to parse the result.
 
    // 4. decode the JSON into your model object annd print the result
 
 00:28 If you need to refresher on parsing JSON, take a look at the notes below the video and refer back to the last lesson to see how we did this.
 */

/*
 Text under the video:
 For a refresher on JSON parsing, refer to "From JSON to Struct with Codable" in lesson 3.
 */

/*
 Spoiler alert!
 Our solution is below. You'll learn more effectively if you give the exercise a strong effort before comparing your code with ours!
 For help check also:                 https://github.com/alexpaul/Parsing-JSON-Review/blob/master/PlayingWithJSON.playground/Pages/Parsing-Array.xcplaygroundpage/Contents.swift
     https://developer.apple.com/swift/blog/?id=37
     https://github.com/TiffanyObi/Parsing-JSON-Review/blob/master/PlayingWithJSON.playground/Pages/Parsing-Array.xcplaygroundpage/Contents.swift
 */

import Foundation // 1. had to improt Foundation

// MARK: JSON data
// temprary commented out from line 36 to line 77

var jsons = """
    {
        "name": "Pluto",
        "type": "diverse",
        "standardGravity": 21.1,
        "hoursInDay": 100
    }
""".data(using: .utf8)!

// MARK: create model(s)
// TODO: 1. create a struct called "Planet" that conforms to Codable protocol ~ create a struct to represent this JSON object in Swift

struct Planet: Codable {
    // TODO: 2. the struct should have properties with matching names and data types to the JSON ~ using properties of the corret datatype,
    // 00:16 for the properties, we can get these from the JSON keys.
    // 01:05 all right, so we have our model objects based on our JSON data. Now it is time to parsing.
    var name: String
    let type: String
    let standardGravity: Double
    let hoursInDay: Int
}

// TODO: 3. create a JSON decoder ~ and as per step 1. the struct should conform to the codable protocol, using a JSON decoder to parse the result.
// 01:09 Whenever you parse JSON in Swift, you'll need a JSON decoder,

let decoder = JSONDecoder() // this object is responsible for the actual parsing, let's add one here - adding "JSONDecoder()"T

// TODO: 4. decode the JSON into your model object annd print the result
// 01:17 To use the JSON decoder, we need to call this decode method. The decode method can trhow an error, so I am going to wrap it in a do block to be safe, hense will mark this call with try.

do {
    // 01:33 and for actual parsing I'll save this into a constant called the earth
    // 01:41 for the type, I'll pass in planet.self and we're decoding from the JSON data we created earlier,
    let  pluto = try decoder.decode(Planet.self, from: jsons)
    // 01:50 if the parsing was cuccessful let's print out the value of earth to see what we get and there it is.
    print(pluto)
} catch { // 01:31 So in the catch block we know that something went wrong, let's just print out the error,
    print(error)
    
}


// 01:57 We created a model object for our JSON data, and used the JSON decoder to convert the data into an instance of the planet struct. That's all we need to do here. Throughout this lesson you're going to encounter a lot of very JSON examples and that's by design. Whatever the JSON data represents, it can be parsed using the same techniques which can in turn be used in real-world apps. Speaking of apps, we're still working on the ranDog app from the last lesson and there's still some features to add which will benefit from JSON parsing techniques. Let's see how next.





