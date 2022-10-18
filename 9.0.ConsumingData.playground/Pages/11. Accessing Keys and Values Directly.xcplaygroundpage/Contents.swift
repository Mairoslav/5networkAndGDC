//: [Previous](@previous)

import Foundation

// MARK: 11. Accessing Keys and Values Directly

// 00:00 We have covered a lot of JSOn parsing technkques in this lesson:

/*
    - (5) Coding Keys (a way to map differently named JSON keys to Swift property names)
    - (7) JSON Arrays/Parsing JSON Arrays
    - (9) Nested JSON objects
    /// last one is being discussed in this lesson/now
    - (11) Accessing keys and values (treating a JSON object like a dictionary when we don't know what the keys and values will be)
 */

// 00:11 We are almost ready to tackle the breeds list JSON from the dogAPI. There is just ome more parsing trick I wanted to show you bofore we continue. Remember how in the breeds list the information we wanted, specifically breed names were strored in JSON keys. Well, in the examples we have seen so far, we alrady know what the JSOn keys are. But in this case, we do not know the keys in advance.
// 00:33 However it's still possible to get this ifnormation when decoding JSOn in Swift. JSON objects are just a collection of keys and values. This is much like a dictionary in Swift and we can use this to our advantage. Let's see what this looks like in one more example.
// 00:51 I have modified the house JSON data one more time. It stores the same information as before but with a twist. Instead of storing the objects in an Array, both objects are being stored in a JSON object, each with a separate key, 100 and California. For convenience sake, let's call this key a carMark or a unique way to identify a car. Try not to worry about why anyone would actually do this when an Array works just fine?
// 01:17 The point is that different APIs will structure their data differently. So it's important to be prepared when you encounter real world's JSON data. With this change, we can no longer parse directly into an array of host strengths. We can however still parse it into a dictionary. To do this, let's change the data type we're decoding into.

// 01:39 Keys are Strings and values are valid car objects. So let's change this to a dictionary with a matching type.
// 01:46 I am also going to change the name here to be more descriptive i.e. "let carDict ... print(carDict)". So technically, we've parsed the JSOn and have an instance of the car struct for each object. To convert these to an Array, we can use two properties of switch dictionaries:
        // 01:59 The 1st is called values. We can map over each element in values qan get a Car struct  which is added to the Array.
        // 02:10 Similarly, if we just wanted the carMark, we could loop over the keys property of the dictionary.

// 02:15 In both cases, we can now see all the cars and carMarks printed out. This is not something you will need to do all the time. Usually, decoding the entire JSON object into a struct will work. However, for situations where your code does need to access keys and values of JSOn objects diredctly, and will see this soon, dictionaries provide a convenient way to do just that. For now, let's get back to the ranDog app to implement the breeds list feature.

let json = """
{
    "skoda1000cka": {
        "producer": "skoda",
        "year_of_production": 1985,
        "accessories": ["headCushion", "elbowRest"],
        "price": {
            "cash": 2900,
            "lease": "N/A"
        }
    },
    "California": {
        "producer": "vw",
        "year_of_production": 2022,
        "accessories": ["bed", "kitchen", "toilet", "shower"],
        "price": {
            "cash": 120000,
            "lease": "27 x 370 EUR + 3%"
        }
    }
}
""".data(using: .utf8)!

struct Price: Codable {
    let cash: Int
    let leasing: String
    
    enum CodingKeys: String, CodingKey {
        case cash
        case leasing = "lease"
    }
}

struct Car: Codable {
    let producer: String
    let year: Int
    let accessories: [String]
    let price: Price
    
    enum CodingKeys: String, CodingKey {
        case producer, accessories, price
        case year = "year_of_production"
    }
}

do {
    let carDict = try JSONDecoder().decode([String: Car].self, from: json)
    print(carDict)
    let cars = carDict.values.map({$0}) // 01:59 map over each element in values can get a Car struct  which is added to the Array
    let carMark = carDict.keys.map({$0}) // 02:10 similary, if we just wanted the carMark, we could loop over the keys property of the dictionary.
    print("... ... ...")
    print(cars) // ~ values
    print("... ... ...")
    print(carMark) // ~ keys
} catch {
    print(error)
}

/*
 We just saw a variety of techniques for common JSON parsing scenarios

  - (5) Coding Keys (a way to map differently named JSON keys to Swift property names)
  - (7) JSON Arrays/Parsing JSON Arrays
  - (9) Nested JSON objects
  - (11) Accessing keys and values (treating a JSON object like a dictionary when we don't know what the keys and values will be)
 
 Now it's time to return to the documentation - https://dog.ceo/dog-api/documentation/. Take a look at the JSON response for listing all breeds (breeds/list/all). Then answer the following question.
 
 // TODO: Reflect
 // Which of the JSON parsing techniques discussed could help with parsing the breeds list JSON?
 // see next Playground page
 */

//: [Next](@next)
