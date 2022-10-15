//: [Previous](@previous)

import Foundation

// MARK: 4. Breed List Response

/*
 00:00 Let's take a look at the breeds list JSON in more detail, keeping in mind our end goal to produce a String array of all dog breeds. When we parsed JSON objects in the previous lesson, we created a property whose name corresponsd to each key in the JSON object. Here we have two keys, status and message.
 */

/*
"""
{
    "status": "success",
    "message": {
        "african": [],
        "australian": [
            "shepherd"
        ],
"""
*/
// 00:22 Message is what the dogAPI called our URL when we fetched it into image, and now is calling this entire JSON object as the message. The meaning of the name message depends on the data returned by the API. If we were to create a property names message in our code, then the meaning would be ambiguous and confusing to readers, including ourselves.

// MARK: thing One to notice
// 00:43 We're trying to get a list of breeds so perhaps, breeds would be a more appropriate name. (1st difference) The only problem is that nothing in this JSON is called breeds. So we need to customize the property names in our code and not just rely on the names of JSON keys.

// (2nd difference) The second difference you may have noticed with this response is that there appears to be JSON objects within JSON objects.

//01:05 So far we have only parsed JSON with basic types. We need a way to handle parsing nested JSON objects like we have here.

// MARK: thing Two to notice
// 01:13 Another thing you might have noticed is that some values are consisting of brackets. Like is Swift, these are Arrays, there are not keys and values, just a list of Strings separated by commas. These inner arrays are actually sub-breeds. Which we don't care about for our apps feature, but it is ineresting to note that JSON can contain Arrays of other values. We'll explore JSON in detail later in this lesson.

// MARK: thing Three to notice
// The last interesting thing about this JSON I want you to see, are these keys: "african", "australian"... Previously, when we extracted the URL for our random image, the URL was the value (value after key, as key: value). here however, the information we want is actually stored in the keys. We do not know the keys beforehand, so we can't create a property for let's say "african", , "australian" and so on. Not to mention, it would be quite tedious.

// 02:03 We need a way to access these keys' contents whatever the key may be. So we can see that the way we've parsed JSON so far isn't quite enough. Thankfully, Swift's codable protocol prpovides a lot more reatures for working with even the most complicated JSON objects. Rather than simply showing you how to parse this JSON, we're going to take a break from the ran dog app to go over some of the most common JSON parsing challenges and some techniques you can use when you encounter them. Well, not every technique will be needed for the breeds list JSON. You'll learn a lot more about decoding JSON objects and get a lot of practice along the way. Then, you'll get the chance to use what you've learned to implement the breeds list feature in the ranDog app. 

//: [Next](@next)
