//: [Previous](@previous)

import Foundation

// MARK: 15. Breeds List Walkthrough

// 00:00 Let's walk through each of the steps for implementing the breeds list. My solution may differ from yours, and that's okay. But I am going to keep things consistent whith the code we've already written.

// MARK: 1.
// 00:11 The first thing we need to do is add this URL to our endpoints enum. Do this by going to DogAPI.swift file and adding an enum case called listAllBreeds, only to add a new case to our switch statements to return the URL that you get from documentation: https://dog.ceo/api/breeds/list/all

// MARK: 2:
// 2a. 00:31 Now, to make a request to this URL, we also need to add another method to our API class, I'll call this requestBreedsList. Its only parameter will be a completion handler. This will pass back an Array of Strings and an optional error. Like the others, I'll mark it as @escaping and notice the return type is still Void.
// 2b. 00:54 Now to make the request, we'll create a new task using the shared URL session. Calling dataTask will pass in the listAllBreeds URL. And we'll get back data, response, and en error.
// 2c. 01:11 The first thing we do in the body of the completion handler is check to make sure we got data back using a guard statement. We'll call the completionHandler, passing in an empty Array meaning we did't get any dog breeds, hence the error if something went wrong. We then need to return from the closure. But if the request was successful, we'll continue on it parsed the data. This is exactly like we do for the other methods, and you're probably starting to notice thhat a lot of this code is the same.
// 2d. 01:38 The one other thing we need to do for every network request is to call taskThree.resume(). This ensures that our request actually gets executed.
// 2e. 01:48 All right, so to actually parse theh JSON, let's take one more look at the documentation: https://dog.ceo/dog-api/documentation/ checking "List all breeds" window. The response is a JSON object with a String property called "status" with a value of "success". And in this "message" property, we have another JSON object. So, we're going to need our knowledge of nested JSON objects in order to parse this. If you look at the contents of this JSON object, we can see that each of the breeds are keys. Our app doesn't know these keys in advance, so to access them, we can use a dictionary like we did before. We're only concerned with the list of breeds and the rest of this data we actually do not need. So, I think we're all st on how to parse this. Let's go back into Xcode and do that now. 02:33 To keep our project organized, I am going to add the struct in a new file but it could work anywhere. Under the Model group, I'll add a new Swift file and I'll call this BreedsListResponse, and I'll add there new struct being called BreedsListResponse making sure it conforms to the Codable protocol as we'll need two properties: 1. "status" which is a String and "message" which is a dictionary. These dictionary keys are the actual dog breeds. The values are arrays of Strings. We won't actually need to access the values but I'll set the keys type to String and the values to String Array.
// 2f. 03:17 Then back in the API class, once we know we got data from the server we can parse the JSON. I'll create a new JSON decoder. And will parse it into a constant called breedsResponse. Passing in breedsListResponse as the type to parse into as well as the data we're trying to parse. Assuming our JSON is valid, we can disable error propagation with try, but you're welcome to handle it using a do-catch.
// 2g. 03:45 Now that we have the responses' usable Swift type and we know the keys of the message property or the dog breeds we want, let's convert the keys propety to an Array of Strings. We can do this by mapping over the keys.
// 2h. 03:58 Finally, we can call the completion handler passing in the breeds and nil for the error. So that's the code for making the request. Now let's head over to the ViewController to call it. Check ViewController.swift.

// MARK: 3
// 3a. 04:09 Like the other requests, I am going to crate a new nethod to act as the completion handler. We'll all it "handleBreedsListResponse()" and it will take the same parameters as the completioin handler for the mehtod we just created, and Array of Strings for the breeds and an optiona error in case something went wrong.
// 3b. 04:29 In this method, all we need to do is update the breds list and reload the data. So I'll assign self.breeds, our global property  to the breds list that we got back from the server. Breeds is currently a constant but I am going to change it to a variable so that we can update its value (*** change from let to var).
// 3.c. 04:46 To update the picker, just like a table view, we need to reload the data. But because we're updating the UI, we need to do this on the main thread. So I am going to add a call to async here and reload the data I'll call self.pickerView.reloadAllComponents().

// MARK: 4
// 4a. 05:04 There just one more step to get the breeds list working. We need to make our request. We'll do this in a viewDidLoad(), to ensure we fetched the breeds list immediatelly upon app does launch, passing in "handleBreedsListRespponse" as the completion handler.

//: [Next](@next)
