//: [Previous](@previous)

import Foundation

/*
 We just saw a variety of techniques for common JSON parsing scenarios

  - (5) Coding Keys (a way to map differently named JSON keys to Swift property names)
  - (7) JSON Arrays/Parsing JSON Arrays
  - (9) Nested JSON objects
  - (11) Accessing keys and values (treating a JSON object like a dictionary when we don't know what the keys and values will be)
 
 Now it's time to return to the documentation - https://dog.ceo/dog-api/documentation/. Take a look at the JSON response for listing all breeds (breeds/list/all). Then answer the following question.
 
 // TODO: Reflect
 // Which of the JSON parsing techniques discussed could help with parsing the breeds list JSON?
 // My answer: (11) Accessing keys and values
 // Feedback from Udacity: The JSON for listing all breeds includes nested objects, Arrays, keys that we do know beforehand, and keys we may want to map to differen Swift properties. We can definitely use these strategies for parsing the breeds list JSON. We'll do this as we build our ranDob app.
 */

var json = """
{
    "dog": {
        "african": [],
        "australian": ["shepherd", "bb"],
        "basenji": [],
        "buhund": ["norwegian"]
    },
    "status": "ok"
}
""".data(using: .utf8)!

struct Dog: Codable {
    let dog: [String: [String]]
    let status: String
}

do {
    let dogDict = try JSONDecoder().decode(Dog.self, from: json)
    print(dogDict)
} catch {
    print(error)
}

//: [Next](@next)
