//: [Previous](@previous)

import Foundation

// MARK: 8. What is JSON?

/*
 00:00 We have just executed our first HTTP request using tge DogAPI which returns some bytes representing a JSON response. We have heard about JSON briefly at the start of this lesson but we still haven't used this data in our app. First, let's take a closer look at what a JSON response is.
 
 00:20 So what is JSON? JSON stands for JavaScript Object Notation. It provides a syntax or set of rules for storing text. You may recognize JavaScript as the name of a programming language used on the web, hence the syntax is meant for it to be easily converted to and from JavaScript objects. However, while it shares a similar syntax to JavaScript objects, JSON is not just for JavaScript. Because of its widespread use on the web and its easy-to-read syntax, many languages, including Swift, support JSON making it a great format to exchange data between client and server.
 
 01:00 We've already seen an example response from the Dog API but let's take a look at some sample JSON data to better understand the syntax. Here we have some JSON providing us with some data about a house. This JSON data begins with an opening brace and ends with a closing brace. The braces and everything contained between them is a JSON object.
 
{
    "type": "colonial",
    "location": "Plainville, MA",
    "bedrooms": 3,
    "bathroom": 2.5,
    "has_air_conditioning": false
}
 
 01:24 A JSON object can have one or more properties consisting of a key and a value just like a dictionary in Swift. Keys and values are separated by a colon ":" with keys on the left side and values on the right side. Keys are contained in quotation marks and key-value pairs withing the JSON object are separated by a comma ",". Let's take a look at these values. 01:45 You might recognize the values for type and location as strings. Placing quotation marks around values means that the value is a String. JSON objects can also store numbers. Here we have three for number of bedrooms. Notice how there are no quotation marks for integers and we can represent floating-point values as well, see 2.5. There's even a Boolean value that can either be true or false. These are also written without quotation marks as Boolean is its own type, it's not a String.
 
 02:26 We're going to explore some more examples of JSON data in the next lesson but for now, let's get back to the question: MARK: How do we represent this object in Swift?
 
 Like JSON objects, Swift dictionary store data with keys and values. This is one way we can represent JSON data in our app. If we wanted to specify Swift data types like String, Int, Double or Bool for each value, the process for getting values out of this JSON is called parsing and we could parse this JSON data in different ways such as:
        
        a) converting to a dictionary
        b) or even into a custom struct 02:57.
 
 A common practice for medelling the objects that are received over the network. Both approaches are available when parsing JSON 03:09:
 
 
        1. JSONSerialization - Converts JSON data to and from Swift dictionaries. This is the method traditionally use to parse JSON in iOS apps. With the JSONSerialization, the JSON object is treated like a dictionary.
 
        2. Codable - The moder approach is Codable, a protocol used to convert data, like JSON, to and from Swift types (introduced in Swift 4). With parsing the JSON object this way, 03:27 the data is first converted into an struct where you can then extract individual values. While in most modern Swift apps, you'll likeli want to use Codable. You man come across JSONSerialization in older  projects or if the code was written in Objective-C.
 
 03:45 We're going to parse the JSON from the Dog API using both approaches. First step, I'll show you how to do this using JSONSerialization (1).
 
 */
// MARK: text under the video:
// Let's take a look at another JSON object to identify the keys and values. This one represents a cake.

/*
 {
     "type": "chocolate",
     "frosting": "vanilla",
     "calories": 2380,
     "healthy": false
 }
 */

/* MARK: question1.which of the following are keys in this JSON object?
    - Chocolate
    - "calories" YES
    - "chocolate"
    - "Healty"
    - "type" YES
    - "frosting" YES
    - "vanilla"
    - "healthy" YES
 
 Correct! Keys are to the left of the colon in each pair. The keys are "type", "frosting", "calories", and "healthy".
*/

/* MARK: question2.which of the following are values in this JSON object?
    - 2380 YES
    - false YES
    - "type"
    - "calories"
    - "chocolate" YES
    - "vanilla" YES 
    - "false"
 
 Correct! Values are to the right of the colon in each pair. The values are "chocolate", "vanilla", 2380, and false.
 */

//: [Next](@next)
