//: [Previous](@previous)

import Foundation

// MARK: 8. Arrays Walkthrough B - as per lesson

var json = """
[
    {
        "title": "Groundhog Day",
        "released": 1993,
        "starring": ["Bill Murray", "Andie MacDowell", "Chris Elliot"]
    },
    {
        "title": "Home Alone",
        "released": 1990,
        "starring": ["Macaulay Culkin", "Joe Pesci", "Daniel Stern", "John Heard", "Catherine O'Hara"]
    }
]
""".data(using: .utf8)!

struct Movie: Codable {
    let title: String
    let released: Int
    let starring: [String]
}

let decoder = JSONDecoder() // possible to skip this and directly write "JSONDecoder().decode" in do block 
// let comedies: [Movie] // alternative A: "let comedies: [Movie]"

do {

    let comedies = try decoder.decode([Movie].self, from: json) // alternative B: write "let" in front of comedies
    print(comedies)
} catch {
    print(error)
}

//: [Next](@next)
