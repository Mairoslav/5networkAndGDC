//: [Previous](@previous)

import Foundation

/*
 Lesson Objectives:
    - Map JSON keys to different property names with Coding Keys.
    - Parse nested JSON objects into multiple different structs.
    - Decode JSON arrays into Swift arrays.
    - Parse JSON without knowing the keys in advance.
    - Translate documentation into a network request, and parse the JSON result.
 */

/*
 00:00 Welcome to the lesson on consuming networked data. By now, you've already worked through the JSON and saw how it can be used as a simple format to exchange data between the client and server.
 
 00:17 We saw that JSON objects are made up of a) keys and b) values, where a) keys are Strings and b) values can be of many different data types familiar to swift, like Int, Double, String, Bool...
 
 00:32 We then used this knowledge to parse our first JSON response from the DogAPI. That's a good 1st step, but there's a lot more to working with JSON. Although JSON data is a consistent easy to read format, web APIs such as the DogAPI, structure their JSON responses in a number of different ways to represent more sophisticated data than we've encountered.
 
 00:55 We'll need to take our JSON parsing knowledge a step further to be confident working with all kinds of JSON. In this lesson, we'll discuss some of the most common JSON parsing scenarios and how to handle them in Swift. In the process, you'll get a lot more confident parsing more complex JSON objects and then use that knowledge to add a new feature to the ranDog app.
 
 01:17 Before we get started, let's take a quick review of JSON parsing, and then we'll see that new feature in action. 
 */

//: [Next](@next)
