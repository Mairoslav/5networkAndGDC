//: [Previous](@previous)

import Foundation

// MARK: 3. Improving the Networking Architecture

// MARK: video1
// 00:00 Our goal is to add more features to the movie manager, but with more features comes more code. An app development and really any software project, it is important to make sure that your code is of high quality, not just that the app works. Adding too many features, so that thinking about how your code is structured can quickly lead to the code becomming messy and unmaintainable. Before we move forward, take a look at the code you have written so far. Specifically, the networking code and its all the code to make data tasks here. What do you think we could refactor?

// 00:31 Is there anything else we could do to improve our code quality? There are many right answers here, but there is probably at least one thing with our networking code that could be improved. When you are done we will talk about one possbile strategy that we'll use to improve our networking architecture.

// MARK: Reflect - How might we improve our networking code to make it more maintainable?

// my response: seems like requests are the same except of the few specificities...
// Udacity: Thanks for your response. Let's see an example strategy for refactoring in the following video2.

// MARK: video2
// 00:00 There are many ways we could improve the networking code. And you'll probably see different developers to structure it differently. There are even a 3rd party libraries to make your apps network architecure more managable. Well there is no only one way to structure the code, there are few problems to stand out:
    
    // MARK: 3. The url they request from
    // 00:15 1st, it looks like a lot of our code is being repeated. We have two GET requests with very similar logic just with a few differences. Each method is just passed a different URL, when we call dataTask (check this in "TMDBClient.swift").

    // MARK: 2. The completion handler they pass back.
    // 00:32 2nd, and each one parses that result to different Codable struct.

    // MARK: 3. The type they parse into.
    // 00:35 3rd After the parsing stage, each method does handle the date in a slightly different way. For instance:
            // in "getWatchlist" method, A) an array of containing the movies in the user's watchlist is passed back to the completionHandler.
            // 00:49 Whereas here the "getRequestToken" method, B) we set the requestToken in the Auth struct and then parse back a Boolean for whether or not the request was successful.

// 00:58 Aside from the URL we pass in and the way we handle responses, everything in this method is the same. When you have a lot of repeated code wiht only a few values that are different, it's a good idea to refactor it into a separate method. The different values can be supplied to the new function as parameters.

// 01:15 The goal is that when we start adding new features to our app, we won't have to type all this code again. To extract our repeated code, we'll create new function that handles all the work of handling network request. I'll call this "func taskForGETRequest()" because it is responsible for executing a "dataTask". Let's think about the parameters we will use.

// 01:34 Every GET request has a URL, but it differs for each request we make. So it makes sence to pass in the URL as a parameter.

    // "func taskForGETRequest(url: URL)"

// 01:44 Every GET request also has some type of JSON response, parsed into a Codable struct. However we do not know the exact type. We can get around this using our knowledge of generics, adding a ResponseType which can be any type that conforms to Decodable.

    // "func taskForGETRequest<ResponseType: Decodable>(url: URL)"

// 02:00 Of course Swift fuctions cannot be specialized like we have seen earlier, but we can pass in the specific type as parameter.

    // "func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type)"

// 02:06 Finally like other functions, we need to alert the calling function when the task is complete. So we'll need a parameter for completion handler.

    // "func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping() -> Void)"

// 02:13 At this point we've either parsed the results or received an error. Both parameters are optional, a ResponseType? and Error?.

    // "func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping(ResponseType?, Error?) -> Void)"

// 02:22 As for making the request, we keep the same methods we have already created, hence/and called the respective completion handlers in the completion hadler of "taskForGETRequest()". Now these functions only contain the essential information. All the heavy lifting of making the request and parsing the result is handled by "taskForGETRequest()".

// 02:41 Back in the Movie Manager, there's one other area of repeated code that's less obvious, but fixing it will make our lives easier as we add more features. Notice how in the "LoginViewController.swift", every time we access the UI, we have to wrap our code in "DispatchQueue.main.async { ... }. However every completion handler for each request will probably need to interact with the user interface at some point, so it will need to run on the main thread.

// 03:09 Instead we can move these calls into "TMDBClient.swift". And since we will be extracting our networking code into the new "taskForGETRequest()" method, we only need to call for those completion handlers. You'll see what this refactoring will look like shortly, but first Reflect on steps needed for refactoring the "GET tRequest" and see if the same strategy could be also applied to the post requests.


// MARK: text under the video2
/*
 For the two GET requests, everything is the same except for a few differences.

 - The "url" they request from
 - The completion handler they pass back.
 - The type they parse into.
 
 The first one is straightforward. Whatever the URL is, we just pass it into the "dataTask" method. This can be made into a parameter in our new function.
 
 For the completion handler: in one function, we pass back a "Bool" and an "Error?" whereas in the other we pass back types "[Movie]" and "Error?". However, both the "Bool" and "[Movie]" come from parsing the JSON. So in "taskForGETRequest"'s completion handler, we can pass back an instance of whichever type we pass into "JSONDecoder.decode()"
 
 And we can parse into any type (a "Codable" struct) so we need to pass in the type as a parameter. Only that in order for this to work, we need to make it a generic.

 The rest of the code is the same. We just extract it into the "taskForGETRequest" method with parameters that look like this..
 
 class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void)
 
 */

// MARK: Quiz Quesion - Now that we've identified the similarities in the code for making GET requests, take a look at the code for making POST requests. What differences between the methods for logging in and creating the session ID could be used for refactoring? (*** here not sure if all number-letter paired correctly)

// 1. The value saved in the "Auth" struct          (YES DIFFERENT) ... D In addition, the one other thing that POST requests have, is an Encodable type for the request body. So if we wanted to refactor the code for making POST requests, we'd have all the same parameters as our theoretical taskForGETRequest with an additional parameter for the request body, and its accompanying generic.

// 2. THe "httpBody"                                (YES DIFFERENT) ... C completion handler (actually, the completion handlers are the same, but they may not be for every POST request, AND if we refactored into a separate method, we'd need to take a completion handler parameter as well.

// 3. The response type (passed into "decode()")    (YES DIFFERENT) ... B The type being parsed into

// 4. The "Content-Type" header                     (NO, THE SAME)
// 5. The "httpMethod"                              (NO, THE SAME)

// 6. The URL                                       (YES DIFFERENT) ... A the URL

/*
 Thanks for completing that.
 
 When looking to refactor a method, ask yourself 1) what are the differences between two functions and 2) can they be made into parameters.

 The POST requests share all the same differences with the GET requests.
 
 A. the URL
 B. The type being parsed into
 C. completion handler (actually, the completion handlers are the same, but they may not be for every POST request, AND if we refactored into a separate method, we'd need to take a completion handler parameter as well.
 D. In addition, the one other thing that POST requests have, is an Encodable type for the request body. So if we wanted to refactor the code for making POST requests, we'd have all the same parameters as our theoretical taskForGETRequest with an additional parameter for the request body, and its accompanying generic.
 
 All the other code for making the POST requests is exactly the same.
 
 Don't worry if this still sounds a little abstract. The benefit of refactoring this way will make more sense once you see the code.
 
 */

//: [Next](@next)
