//: [Previous](@previous)

import Foundation

import Foundation

// MARK: 7. JSON Arrays B

// 01:56 [ ... ]
let jason = """
[
{ "svetle": true,
  "vyhody": ["movable", "ecologic"]},
{ "svetle": true,
  "vyhody": []}
]
""".data(using: .utf8)!

struct Studio: Codable {
    let lightFull: Bool
    let amenities: [String] // just add an Array property and a CodingKey if needed.
    
    enum CodingKeys: String, CodingKey {
        case lightFull = "svetle"
        case amenities = "vyhody"
    }
}

do {
    let studio = try JSONDecoder().decode([Studio].self, from: jason) // *******
    print(studio)
} catch {
    print(error)
}

// 01:46 Now, what if the JSON objects was instead an Array of other JSON object? We can handle that too.
// 01:53 Here I have modified our JSON to include more than one Studio.
// 01:56 You will notice that the root of our objects, the 1st character is an opening bracket [, and our JSON ends wiht a closing bracket ]. On the inside, we have two JSON objects, and they are separated with a comma as Array elements.
// 02:10 Like the 1st object, this 2nd object in the Array shares all the properties of the 1st, including the String Array of amenities, which just so happens to be empty for this 2nd object.

// 02:23 In other words, the JSON object is an Array, where each element is a Studio that can be converted itno an instance of the Studio struct.
// 02:29 So if we go donw to where we decode the JSON right now, we're trying to convert it into a single instanc eof the Studio struct. However, our JSON represents an Array of Studios, so I am going to change this type to be an Array by adding brackets, and there we have it *******.
// 02:46 Our output shows an Array with both instances of the Studio struct, reflecting the same structure as the JSON data, all might changing the type to an Array. So, the key takeaway here is that, if a type conforms to the Codable protocol like any basic type or our entire Studio does, then an Array of those objects can easily be converted to and from JSON data. You just need to specify the type as an Array. Let's get some practice doing that now. 

/*
 // TODO: text under the video:
 Time to try another JSON parsing exercise - this time with arrays. You'll see we have a new JSON object, this time, where the root object is an array. Each element in the array is another JSON object that represents a movie.

 The movie object has three properties: title, a String;released, anInt; andstarringan array of strings ([String]`).

 Below, there's a Movie struct that already declares its conformance to Codable and has both a property for title and released. Your task is to modify the code to correctly parse the arrays.

 Add a property to the Movie struct so that the starring array is parsed correctly. In the do block, decode the JSON into an array of movies ([Movie]).

 If you get stuck, refer back to the example in the video.
 */


//: [Next](@next)
