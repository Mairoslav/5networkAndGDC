//: [Previous](@previous)

import Foundation

// MARK: 7. JSON Arrays

//  00:00 Earlier in this lesson, we saw brackets show up in a JSON response. Like in Swift, brackets denote an array, which we can use as a value in a JSON objects to denote a list of ordered data.
// 00:14 In JSON objects, an array can be either:
    /// a property, like the Strings and numbers we alrady have,
    /// or it can alo be the root of the entire JSON object.
// 00:23 In other words, the JSON data represents an Array of other JSON objects. We'll see an example of both types.
 
// 00:34 *** First, let's say a House JSON should also include a list of amenities (a desirable or useful feature or facility of a building or place, "the property is situated in a convenient location, close to all local amenities"). Each one is a String, and there can be multiple listed per house. So this wold be a good scenario to use an Array.
// 00:45 Here we have added two element to our value: "movable" and "ecologic". Note that this value begins with an opening bracket and ends with a closing bracket []. Each element is String, and they are separated by this comma here. That's how we can represent an Array of Strings using JSON.
// 01:04 Now, what about modifying our parsing code to handle it? Well, Swift Arrays actually conform to the Codable protocol, so we can simply add a new property "amenities", and said it's typed to an Array of Strings.

let jason = """
{ "svetle": true,
  "vyhody": ["movable", "ecologic"]}
""".data(using: .utf8)!

struct Studio: Decodable {
    let lightFull: Bool
    let amenities: [String] // just add an Array property and a CodingKey if needed.
    
    enum CodingKeys: String, CodingKey {
        case lightFull = "svetle"
        case amenities = "vyhody" // 01:17 Remember that we also need a CodingKey for each property, so I'll add a case called amenities here.
    }
}

do {
    let salas = try JSONDecoder().decode(Studio.self, from: jason)
    print(salas)
} catch {
    print(error)
}

// 01:24 As you can see in the output, that our JSON is once agai being decoded into the Studio struct, and we can see the amenities property contains an Array of Strings. Cool, so that's how we can handle Arrays that our JSON contains.
// 01:38 We can just add an Array property and a CodingKey if needed.

// 01:46 Now, what if the JSON objects was instead an Array of other JSON object? We can handle that too. 

/*
 // TODO: text under the video:
 Time to try another JSON parsing exercise - this time with arrays. You'll see we have a new JSON object, this time, where the root object is an array. Each element in the array is another JSON object that represents a movie.

 The movie object has three properties: title, a String;released, anInt; andstarringan array of strings ([String]`).

 Below, there's a Movie struct that already declares its conformance to Codable and has both a property for title and released. Your task is to modify the code to correctly parse the arrays.

 Add a property to the Movie struct so that the starring array is parsed correctly. In the do block, decode the JSON into an array of movies ([Movie]).

 If you get stuck, refer back to the example in the video.
 */

//: [Next](@next)
