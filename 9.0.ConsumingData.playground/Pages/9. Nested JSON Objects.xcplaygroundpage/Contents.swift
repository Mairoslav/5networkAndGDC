//: [Previous](@previous)

import Foundation

// MARK: 9. Nested JSON Objects

// 00:00 Previously, we saw how JSON values could store Arrays and that Array elements can be multiple JSON objects. It turns out the JSON values can also be entire JSON objects.
// 00:15 We first encountered such a value from the breeds list response in the dogAPI. So far we've been expanding upon the House JSON to demonstrate some common JSON features, if we were working with an actual real estate API, then we would probably want some information about the house being sold. How would we model that? Well, for example, let's add two properties to the JSON:
    /// "price": 765000, ~ Integer describing the price in dollars
    /// "date": "Oct 2022" ~ A String to denote when the house was put up for sale. I am not worried about spedific fromatting for the date, just to bump into your will suffice.
// 00:55 Now we could add these properties alongside the others like we did and this would work. But with this many properties, it could be hard to find the values you want.
/*
let json = """
[
    {
        "type": "colonial",
        "location": "Plainville, MA",
        "bedrooms": 3,
        "bathrooms": 2.5,
        "has_air_conditioning": true,
        "amenities": ["basement", "garden"],
        "price": 765000,
        "date": "Oct 2022"
    },
    {
        "type": "krt",
        "location": "Liptov",
        "bedrooms": 5,
        "bathrooms": 2,
        "has_air_conditioning": false,
        "amenities": ["basement", "garden", "forest", "peace", "bio"],
        "price": 1765000,
        "date": "Oct 2022"
    }
]
""".data(using: .utf8)!
*/

// 01:06 Oftentimes, you'll see JSON that looks more like this. Here each house objects has a property called listing

// MARK: JSON objects
let json = """
[
    {
        "type": "colonial",
        "location": "Plainville, MA",
        "bed": 3,
        "air_conditioning": true,
        "plus": ["basement", "garden"],
        "listing": {
            "price": 765000,
            "date": "Oct 2022"
        }
    },
    {
        "type": "colonial",
        "location": "Liptov",
        "bed": 3,
        "air_conditioning": false,
        "plus": ["basement", "garden", "forest", "bio"],
        "listing": {
            "price": 1765000,
            "date": "Oct 2022"
        }
    }
]
""".data(using: .utf8)!

// 01:10 Listing's value is another JSON object that contains specific keys and values for the selling information. When a JSON object is the value for a key and another JSON objects, it's called a nested object.
// 01:25 When parsing nested objects in Swift, we can break up each JSON object into its own struct. So, we'd still have the House struct but we can ***have another struct for the "listing" objets. Let's see what this looks like 01:38.

struct Listing: Codable { // ***have another struct for the "listing" objets
    let price: Int
    let date: String
}

struct House: Codable {
    let type: String
    let location: String
    let bed: Int
    let air: Bool
    let plus: [String]
    let listing: Listing // * add a new property called listing and its type will be Listing
    
    enum CodingKeys: String, CodingKey {
        case type, location, bed, plus, listing
        case air = "air_conditioning"
    }
}

do {
    let house = try JSONDecoder().decode([House].self, from: json)
    print(house)
} catch {
    print(error)
}

// 01:55 Notice that both these properties, price and date, have the same name as the JSON keys, that means we don't need to add a codingKeys here. So we have a struct to represent "listing" data.
// 02:07 Now we need to add a property to the house struct so that this data can be used. So, we'll ** add a new property called listing and its type will be Listing. We can use it here because the Listing type itself does conform to Codable.
// 02:20 We then need to add a case to the codingKeys enum. Property named listing is the same as the JSON key. So we will just add the case here.
// 02:30 Creating a new struct and making the property of the House struct allows us to parse both the House and Listing data which we cna now see in the output.
// 02:40 This is a great way to separate values and complex JSOn objects that you, the developer, will know exactly what each model object contains an it maps perfectly to the JSON data.

/*
 // TODO: Nested JSON Practice
 It's time to practice parsing a JSON object with nested objects. Below, you'll see a JSON object used to represent a student, with several properties including a name, student ID, field of study, and letter grade.

 The name and student ID are at the root of the object. The field and grade are grouped under another JSON object, with the key "academics".

 Your task is to parse this JSON using your knowledge of nested structures, by performing the following steps:

 Create Codable structs for Student and Academics
 Give the Student struct a property for Academics, to match the JSON structure.
 Add the line to decode the result.
 It's recommended to print the parsed student object so you can verify that the JSON was decoded correctly.
 */

//: [Next](@next)
