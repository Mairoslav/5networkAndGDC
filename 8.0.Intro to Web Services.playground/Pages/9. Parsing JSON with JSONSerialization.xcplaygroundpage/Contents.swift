//: [Previous](@previous)

import Foundation

// MARK: 9. Parsing JSON with JSONSerialization

/*
 00:00 when we last ran the Randog app, we cuccessfully executed a GET request and received this data of a 102 bytes, now it's time to turn those bytes into something our app can actually use. Looking at the documentation for JSONSerialization, we see it's an object that converts between JSON and the equivalent foundation objects.
 
 00:25 Down here it refers to NSArray, NSDictionary and NSString among other types. You may not have used these types before but just know that these are the types used in Objective-C. JSON serialization will work just the same for their Swift equivalence, Dictionary, Array, String et cetera and here in Developer Documentation under Topics we can see the functions for creating JSON objects.
 
 00:53 This first one looks like what we want:
 
        class func jsonObject(with: Data, options: JSONSerialization.ReadingOptions) -> Any
            Returns a Foundation object from given JSON data.
 */


// 00:58 (From 9. Parsing JSON with JSONSerialization back to project ranDog) We're going to store JSON object in a new constant, and parse it with JSONSerialization.
// ...
// 01:04 We type JSONSerialization.JSON and slit autotomplete fill in the right function. Notice that this is called on the JSONSerialization class itself, that's because "jsonObject(with: Data..."  is a class method, we do not ever need to create an instance of JSONSerialization. For the data, we just parse in the data we unwrapped using the guard statement. These are the bytes we want to parse as JSON.
// 01:34 For "options:", we are expecting an Array. I am just going to leave this empty, we do not need to do anything with this propert in Swift, but if you'd like to learn more about JSON reading options, I have included more details in the instructor notes.
// 01:47 So, we call JSON object with data but it looks like the compiler is givving us an error: "Call can throw, but it is not marked with 'try' and the error is not handled". 01:52 For exsmple, if the response from the dogAPI were not valid JSON data, it would not be possible for this to succeed.
// 02:00 We can handle this with a do catch and mark it with try. In the even of an error, we can just print it out but if not that means the parsing was successful and we're one step away from accessing the JSON data.
// 02:15 Remember that the format for this object is like a Dicionary where keys are Strings and the values can be of any type. JSON objects with data returns -> Any.
// 02:24 So, we're going to need to force cast it to a Dictionary type ...as! [String: Any]... where keys are Strings and values can be of any type.
// 02:35 Now we can grab the URL from the dictionary ans store it as a String and instead of printing the data, let's now print the URL to see what we've got. Run the app, and if we look at the console, we see the image URL gets printed out. Congratulations, you've successfully parsed the dog APIs JSON response in your app. Parsing JSON with JSONSerialization works just fine with small data like this. However, as we begin workig with more complex JSON, parsing JSON like this will quickly get messy. Next up, we're going to clean up our parsing code to convert our JSON object into a custom struct leveraging the newer MARK: Codable protocol

//: [Next](@next)
