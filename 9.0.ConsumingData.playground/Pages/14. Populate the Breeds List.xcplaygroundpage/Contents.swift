//: [Previous](@previous)

import Foundation

// MARK: 14. Populate the Breeds List

// 00:00 It's time for the fun part. You should be familiar again with the ranDog app and how the breeds list feature works.
// 00:08 All we have left to do is make another request to the dogAPI to get a list of breeds. You have already gotten a lot of practice parsing JSON in this lesson and have already made several network requests in Swift. So I am going to give you the chance to take on this challenge on your own.

// 00:28 Here are the steps we need to get the breeds list working correctly.


// MARK: Steps to populate the breeds list (QUIZ under the video lesson)

// TODO: Add a URL for the breeds list
/// 1. 00:32 Add "listAllBreeds" case to the "Endpoints" enum and make its "stringValue" return the correct URL.
// ~ Add the URL that lists all breeds to the endpoints enum. The endpoint is static so you don't need to add any parameters like we did in the last video, you just need to add another case to the switch statements to return the URL.

// TODO: Create a method to get the breeds list
/// 2. Create a method with a completion handler in DogAPI that requests the breeds list.
// ~ 00:44 Create a new method in the dogAPI class. This medhod should request the breeds list JSON at the endpoint you just added.

// TODO: Make the request,
/// 3. Make a request to the "listAllBreeds" endpoint and parse the JSON. The keys under the "message" object are dog breeds, and should be converted into a String Array.
// ~ 00:52 For the completion handler, you'll want to parse in an Array of Strings which is the list of breeds you will be parsing, as well as the error in case something goes wrong. You can use the same syntax as the completion handlers from the other methods,...

// TODO: and implement the completion handler
/// 4. Create a method to handle the response (act as the completion handler)
// ~ 01:06 you can also create a method XY** in the ViewController to handle the response like we did with the other two requests.

// TODO: Make the request, and implement the completion handler II.
/// 5. Call the new method from the DogAPI class and pass in the method to handle the response as the completion handler.
// ~ 01:12 Then make the request using either a closure or passing in the method XY** you created to handle the response as the completion handler. I'd suggest calling this in "viewDidLoad()" so that you request the list of breeds as soon as the app launches.

// TODO: Parse the breeds list from the JSON & Update the UI
/// 6. In the completion handler method call "pickerView.reloadAllComponents()" on the main thread
// ~ 01:26 Finally in the completio handler, use the techniques learned in this lesson to parse the JSON placing the keys into a String Array. Only the breed names are necessary, you do not need to do anything else with a sub-breeds contained in the inner Array. 01:42 Once you have parsed to the JSON, set thhe breeds Array so that it contains all liberates returned by the API. 01:47 To update the pickerViewsDataSource, call "pickerView.reloadAllComponents()" on the main thread.

// 01:57 There's a lot of steps here so it's best to approach this task one step at a time. Check off the boxes in the checklist as you complete your item and there were a few hints below if you get stuck. When you are done, head on over to the solution video to see the ranDog app fully working.

//: [Next](@next)
