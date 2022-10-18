//: [Previous](@previous)

import Foundation

// MARK: 6. Coding Keys Walkthrough B - as per lesson

/*
 00:00 
 */

var json = """
{
    "food_name": "Lemon",
    "taste": "sour",
    "number of calories": 17
}
""".data(using: .utf8)!

struct Food: Codable {
    let name: String
    let taste: String
    let calories: Int

    enum CodingKeys: String, CodingKey {
        case name = "food_name"
        case taste // = "taste" // note that if the JSON object/key is the same as model objects / propety name enough to write like this ~ 00:58 because raw values are just equal to the case name by default, we do not have to provide a value for this case.
        case calories = "number of calories"
    }
}

let decoder = JSONDecoder()
let food: Food // note when using this syntax we skip writing "let" in front of food as per below code see *****

do {

    food = try decoder.decode(Food.self, from: json) // *****
    print(food)
} catch {
    print(error)
}

//: [Next](@next)
