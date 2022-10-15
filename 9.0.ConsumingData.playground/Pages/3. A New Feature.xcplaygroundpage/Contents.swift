//: [Previous](@previous)

// import UIKit
import Foundation

// MARK: 3. A New Feature

/*
 00:00 Right now, the ranDog app is really basic. We just launch the app, and we get a picture of a random dog. That's all there is to it. Let's fast forward to Randog 2.0, which you'll build later on. In this version of the app, we can specify a breed using the picker view here. And when you have selected a breed, the image should change. To specify a breed for the random image, we can use the endpoint breed/breed/images/random. Breed here is the name of a breed. (on current web-site it is: https://dog.ceo/dog-api/documentation/random).
 
 00:38 This means that by calling this endpoints, the dog API enters and image will be returned for only the selected breed. But how do we get the name of a breed? How do you know what breeds are supported by the API? There's another endpoints to do just that. This one is: https://dog.ceo/api/breeds/list/all
 
00:57 Looking at the response, you can see it contains a JSON object. There's a lot more going on that when we made the request for a random image:
 */

/*
json =
{
    "status": "success", // We have a key "status" with a String "success",
    "message": { // and a key for "message" like before, however this time "message" contains a lot more than the image URL.
        "affenpinscher": [],
        "african": [],
        "airedale": [],
        "akita": [],
        "appenzeller": [],
        "australian": [
            "shepherd"
        ],
        "basenji": [], ...
*/
        /*
         
         /*
          01:14 It looks like we have an entire JSON object, as well as more JSON objects within our response.
          01:21 We also see there's a key for each breed, and we see these brackets [] are used for values.
          
          01:25 This JSON is a lot more sophisticated than what we've seen. To populate the picker used to select a breed, we'll need to turn this response into an array of Strings, where each element is the name of a breed.
          
          01:38 Given your experience with parsing JSON in Swift so far, how confident are you turning this JSON into an array of Strings containing breed names? It's likely that you haven't done anything like this before, and that's what we expect. Just let me know, and then I'll show you what I've thought.
          */
         
         MARK: task under the video - Reflect ........................................................................................
         Take a look at the documentation for listing all breeds. How confident are you converting the breed list JSON into an array of Strings? Enter your response here, there's no right or wrong answer.
         */

// as per my trial - now commented out from line 47 to line 76 - because otherwise in subsequent playgrounds there is an error if not...:
/*
var jsonz = """
{
    "status": "success",
    "message": {
        "african": [],
        "australian": [
            "shepherd"
        ],
        "basenji": [],
        "briard": [],
        "buhund": [
            "norwegian"
        ]
    }
}
""".data(using: .utf8)!

struct Dogs: Codable {
    let status: String
    let message: String
}

do {
    let specialDogs = try JSONDecoder().decode(Dogs.self, from: jsonz)
    print(specialDogs)
} catch {
    print(error)
}
*/

// Error: typeMismatch(Swift.String, Swift.DecodingError.Context(codingPath: [CodingKeys(stringValue: "message", intValue: nil)], debugDescription: "Expected to decode String but found a dictionary instead.", underlyingError: nil))
// Response of Udacity after submitting the trial: There are definitely some challenges parsing this response with the techniques we discussed so far. We'll address each of these challenges in the coming videos.

//: [Next](@next)
