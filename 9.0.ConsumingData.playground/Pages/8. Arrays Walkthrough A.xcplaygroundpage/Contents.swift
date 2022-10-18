//: [Previous](@previous)

import Foundation

// MARK: 8. Arrays Walkthrough - as per my solution

// TODO: text under the video:
// Time to try another JSON parsing exercise - this time with arrays. You'll see we have a new JSON object, this time, where the root object is an array. Each element in the array is another JSON object that represents a movie.

// The movie object has three properties: title, a String; released, an Int; and starring an Array of strings ([String]`).

// Below, there's a Movie struct that already declares its conformance to Codable and has both a property for title and released. Your task is to modify the code to correctly parse the arrays.

// Add a property to the Movie struct so that the starring array is parsed correctly. In the do block, decode the JSON into an array of movies ([Movie]).

// If you get stuck, refer back to the example in the video.

let json = """
[
{ "title": "cierne na bielom koni",
  "released": 2022,
  "starring": ["Mokos", "Petrik"]
},
{ "title": "svetlonoc",
  "released": 2022,
  "starring": ["Tana"]
}
]
""".data(using: .utf8)!

struct Movie: Codable {
    let title: String
    let released: Int
    let starring: [String]
    
    enum CodingKeys: String, CodingKey {
        case title, released, starring
    }
}

do {
    let movies = try JSONDecoder().decode([Movie].self, from: json)
    print(movies)
} catch {
    print(error)
}

//: [Next](@next)
