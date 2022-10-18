//: [Previous](@previous)

import Foundation

// MARK: 5. Coding Keys

/*
 00:00 We have seen one example where we might want to use a different name for a Swift property than we used in a JSON object. Let's revisit our host JSON from the last lesson, to see how to solve this. Here, we have the same JSON object as before with properties for the type of house, its location, number of bedrooms and bathrooms, and whether or not it has air conditioning.
 */

// MARK: JSON objects
let json = """
{   "type": "colonial",
    "location": "Plainville, MA",
    "bedrooms": 3,
    "bathrooms": 2.5,
    "has_air_conditioning": true }
""".data(using: .utf8)!

// 00:24 If we wanted to use it in Swift, we could create a struct with a property for each JSON key and of course, it would need to conform to the codable protocol.

// MARK: model objects / propety names of the House struct
struct House: Codable {
    
    let houseType: String
    let location: String
    let beds: Int
    let baths: Double
    let hasAirConditioning: Bool
    
    // 02:20 And the format is "enum CodingKeys:"... see the code and comments above inserted within struct House marked by ***, after the colon, the raw value is of type "String". And to make this work, we also need to make sure this enum conformts to the CodingKey protocol
    
    enum CodingKeys: String, CodingKey {
        // 02:37 You don't need to wory about how the CodingKey protocol works. It's just necessary for Swift to know that this enum is used for mapping property names to the keys in your JSON object, so that it can be decoded successully.
        // 02:45 So how to we map the property names? Each case in theh enum, has a name. The same as our Swift property, the raw value, which is a String, contains the key name in the corresponding JSON object. And the format is:
        /// case somePropertyName = "some property name"
        // 03:08 We then add cases for each individual property that we need to map from our JSON into our Swift's type.
        // 03:17 For our first case, we want our property name to be "houseType", but in JSON it is just called "type". So we will create a case called "houseType" and set it equal to type.
        case houseType = "type"
        // 03:27 What about the other properties? we map tham the same way as the first one, also in case that the property name is the same as the key name of JSON.
        // case location = "" // **
        case location = "location"
        case beds = "bedrooms"
        case baths = "bathrooms"
        case hasAirConditioning = "has_air_conditioning" // 04:08 with _ between each word, just like the JSON is formatted
    }
}

    // 04:14 Once we have added all the cases, the playground should re-execute and we can see if our house was created successfully.
    // 04:20 So we have maped the JSON keys to our own Swift property names. There's just one more thing I'd like to show you about CodingKeys before you try it out on your own. Remember the location case? Both our Swift property and our JSON key are called location. Did we really need to add this case to our CodingKeys enum? Let's remove it to find out (commented out*****):

// FIXME: error after we comment out: case location = "location"
/*
 expression failed to parse:
 error: 5. Coding Keys.xcplaygroundpage:23:8: error: type 'House' does not conform to protocol 'Decodable'
 struct House: Codable {
        ^

 Swift.Decodable:2:5: note: protocol requires initializer 'init(from:)' with type 'Decodable'
     init(from decoder: Decoder) throws
     ^

 5. Coding Keys.xcplaygroundpage:26:9: note: cannot automatically synthesize 'Decodable' because 'location' does not have a matching CodingKey and does not have a default value
     let location: String
 */

// 04:50 THe first one, type house does not conform to protocol decodable is strange. From the previous lesson, we learnt that the Codable protocol is actually jus the name for two other protocols: Codable and Decodable. So that's a strange error messager for just removing the location case.
// 05:03 Let's look at the second(actually 3rd) error message: "location does not have a matching CodingKey and does not have a default value". So that sounds like this error occurrs because the location key is missing. Even though its property name is the same as the JSON key, when we specify a coding keys' enum, we override the dafault behaviour in which Swift detects the JSON keys. If we set a cas for one key, we need to set a case for all the keys. Like our error states, we could provide a default value for location. For example, make it an empty String **, this commeted out because also throws error.
// 05:39 That's the error, but the location is not actually parsed. If you want to get this value fro the JSON, we need to specify a case. That's all for now on CodingKeys. Not it's your turn. I provided an interactive example, so that you  can try your hand at using CodingKeys. Simply modifiy the struct so that it maps the JSON keys to the struct cusom property names.

let decoder = JSONDecoder()

do {
    let house = try decoder.decode(House.self, from: json)
    print(house)
} catch {
    print(error)
}

// 00:34 Now would this be enough to convert the JSON into a usable Swift object? Let's see. Looks like we're getting an error.
// 00:44 There's a lot of output here. So let's examine it one part at a time.

// 00:47 First, it (error) says: "key not found". Remember that keys are the equivalent of property names in JSON object. So, looks like the property "houseType", from our struct House, is not present.

// 01:00 And the next line, debugDescription: "no value associated with key CodingKeys(stringvalue: \"houseType\",..."

// FIXME: keyNotFound(CodingKeys(stringValue: "houseType", intValue: nil), Swift.DecodingError.Context(codingPath: [], debugDescription: "No value associated with key CodingKeys(stringValue: \"houseType\", intValue: nil) (\"houseType\").", underlyingError: nil))

// 01:09 So it's like that, our JSON does not have a key called houseType, which caused aour parsing to fail. You'll notice that this in only the first property in our Swift struct that does not match the name of a kay in our JSON.
// 01:18 In the JSON object we have bedrooms and bathrooms, whereas in Swift objects, these properties are called beds and baths.
// 01:30 We could just change the names of these properties so they match the JSON keys, but this limits how we can name our properties. We can do it in much better way.
// 01:39 For example, has_air_conditioning here in the JSON uses underscores. But in our struct, we use the more Swift like name hasAirConditioning, using lowerCamelCase.
// 01:51 If key "has air conditioning" had spaces instead, it would remain a valid JSON key. But Swift properties cannot have spaces. So we'd start running into problems trying to make the Swift property names match.
// 02:04 We should not have to change the name of our model objects to match the JSON keys, and thankfully we do not have to. Instead, model objects that conform to the Codable protocol, can use CodingKeys - an enum that tells you what values from the JSON should be stored in your Swift properties.
// 02:20 And the format is "enum CodingKeys:"... see the code and comments above inserted within struct House marked by ***, after the colon, the raw value is of type "String". And to make this work, we also need to make sure this enum conformts to the CodingKey protocol

/*
 MARK: Coding Keys Practice .........................
 Convert the JSON into an instance of the Food struct. Take a look at the property names of the food struct, and how they compare to the JSON keys. You'll notice that the Swift properties and JSON keys are different.

 Modify the Food struct by adding a CodingKeys enum, mapping the property names to their corresponding JSON keys. When you're finished, decoding the Food struct should be successful, and the output will be printed out.
 */


//: [Next](@next)

   

    

