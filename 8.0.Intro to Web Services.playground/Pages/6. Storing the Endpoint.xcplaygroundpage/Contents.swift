//: [Previous](@previous)

import Foundation

// MARK: 6. Storing the Endpoint

/*
 Text under the video:
 
 // MARK: Why a computed property in the enum?
 
 Previously, when we built URLs, we converted strings into an instance of the URL struct using the URL(string:) initializer. We'd need to do this for every single URL we use!

 MARK: By creating a computed property for the URL, we only need to write the code to convert a String into a URL once, and this all happens in the DogAPI class. And less code is always better.
 */

/*
 00:00 OK, so we have our imageView and we want to use it to show a photo of a random dog from the Dog API. For that we're going to need to use that endpoint we found earlier: https://dog.ceo/api/breeds/image/random 00:15 Let's create a new file whre we can store this and future endpoints in okur app. I'll start by creating a new group over here called Model. Networking deals with our apps data, not the visuals. So it fitws into the model category and MVC architecture.
 
 00:34 Now, at here (in Model folder), let's create the new file. It's a swift file, and I am going to  all it DogAPI. In here, we can create a new class to encapsulate all our code for the Dog API. The first thing we'll add is an enum called Endpoint where each case is an endpoint.
 
 00:55 To get our app running quickly let's store each endpoint as the full URL. So we'll give htis enum a raw value of type String, then I can store the first endpoint. I am going to give it a name that reflects how the API refers to it, randomImageFromAllDogsCollection. In Swift, we do not shy away from long names. The goal is to have the name to be as concise as possible without losing information.
 
 01:24Now let's go and copy that URL from the browser, so that we can paste it in here. We don't want it to make a typo, so it's best if we just let the clipbord do the heavy lifing for us. Just be sure to put it in quotes.
 
 01:38 Finally, I'll crate a computed property called URL that we can use to access this endpoint as a URL, which we'll need for making our request. So it will be a variable type URL and we'l use the URL consructor that takes a String parameter to convert self.rawValue into a URL. Since that constructor returns an optional URL, we will need to unwrap it here (either by force unwrap (only when 100% sure that will succeed, here we know that this is a valid URL so are 100% sure) or via ?? ).
 
 02:18 Excellent, so we haver an enum to hold all our endpoints. To verify that this works and doesn't crash, let's try printing the URL from the ViewController's viewDidLoad function. And run the app.
 
 02:30 After runing the app, we won't see anything on the user interface (UI) yet, but the Debug panel should pop up open, and show us the URL, and there it is.
 
 02:40 OK, so we verified that we can store the endpoint and access it as a URL. Next up, let's request an image and see if we get a response.
 */

//: [Next](@next)
