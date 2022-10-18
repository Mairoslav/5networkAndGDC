//: [Previous](@previous)

import Foundation

// MARK: 6. Coding Keys Walkthrough A - try by myself

/*
 MARK: Coding Keys Practice ......................... from previous lesson
 Convert the JSON into an instance of the Food struct. Take a look at the property names of the food struct, and how they compare to the JSON keys. You'll notice that the Swift properties and JSON keys are different.

 Modify the Food struct by adding a CodingKeys enum, mapping the property names to their corresponding JSON keys. When you're finished, decoding the Food struct should be successful, and the output will be printed out.
 */

let jsonx = """
{
    "farba": "red",
    "stiplavost_stupen": 1000
}
""".data(using: .utf8)!

struct Chilly: Codable {
    let color: String
    let spicyGrade: Int
    
    enum CodingKeys: String, CodingKey {
        case color = "farba"
        case spicyGrade = "stiplavost_stupen"
    }
}

do {
    let paprika = try JSONDecoder().decode(Chilly.self, from: jsonx)
    print(paprika)
} catch {
    print(error)
}

//: [Next](@next)
