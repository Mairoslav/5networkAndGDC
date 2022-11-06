//: [Previous](@previous)

import Foundation

// MARK: 8. POST Requests in Swift - video 1

// 00:00 We are one step closer to letting our users authentificate with the movie manager. We have our request token. Now we need to authorize it. As mentioned before, there are two ways for the users to authorize the request token. We'll start with the 1st approach where the user needs to enter their username and password. This method "validate_with_login" does just that, see web: https://developers.themoviedb.org/3/authentication/validate-request-token.
// 00:20 We can see that this is a bit different. It's an HTTP POST request hence down here (scroll down at web-site to ...), we have an additional section called "Request Body" which takes an email or a username, a password and a request token. This is different from what we've seen so far, and is our first POST request in this course. How would we make thi request in Swift?
// 00:44 When we made a GET request, we simly call the dataTask method and passed in the URL for the request.

/*
    let task = URLSession.shared.dataTask(with: url) {
        (data, response, error) in
        // ...
    }
    task.resume()
*/

// 00:50 But POST request does require more informatio than just that. That's why Apple provides another type that we can pass into dataTask called "URLRequest". URLRequest is a struct that holds information about a network request, such as its type and any datasets along with it. When you create a URLRequest, you supply the URL and you can configure the request in other ways. There are a lot of properties and methods on URLRequest. We are concerned with three of them in particular:

    // A. httpMethod: a String that specifieds the type of Request, such as GET or POST
    // B. httpBody: is the data being sent to the server, usually JSON, like we saw in the request body section of the Movie Database's documentation.

// 01:33 How does the web service know the format of the data being posted? Well, when we first discussed HTTP requests, we saw a lot of header information sent with each request. URLRequest has a number of methods for modifying the header.

    // C. addValue(_:forHTTPHeaderField:): we can call addValue(_:forHTTPHeaderField:) to add information to the header. Let's see what this looks like when implementing a POST request:

        // 1st step: 01:57 The first step is to create a URLRequest.
            // var request = URLRequest(url: url)

        // 2nd step: Then the HTTP method is set to the String POST.
            // request.httpMethod = "POST"

        // 3rd step: We'll add a value to the HTTPRequest. The value is "application/json", hence the forHTTPHeaderField is "Content-Type"
            //  request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // 4th step: We then need to assign the httpBody. The body must conform to the Uncodeable protocol, meaning the Swift objects can be converted into JSON, similar to how we used Decodable to parse the response.
            // request.httpBody = data

        // 5th step: To make the request, we just call the dataTask which also accept URLRequest. Everything in the completion handler should be the same. You just parse the result and return an error.
            /*
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                // ...
            }
            task.resume()
            */

        // 02:36 The only difference with a POST request is that you:
        // specify the HTTP method (as per 2nd step)
            // request.httpMethod = "POST"
        // set an apopropriate contents type (as per 3rd step)
            //  request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // and send some Encodable data as the request body (as per 4th step)
            // request.httpBody = data

// MARK: 8. POST Requests in Swift - video 2

// 00:00 So we have just seen how to make a POST request, but how do we get the data for the HTTP body? To format the request body for a POST request, we need the other half of Codable, the Encodable protocol. We have already seen how instances of Swift's types that conform to the Decodable protocol can be created from JSON data. Encodable works the other way around.

// 00:24 If a type like a Swift struct conforms to the Encodable protocol, we can convert it into JSON data. Let's say we have a simple struct for a person, it has a property for name and age, and it conforms to the Codable protocol. Meaning this struct is both Encodable and Decodable.

    /*
     struct Person: Codable {
        let name: String
        let age: Int
     
        enum CodingKEys: String, CodingKey {
            case name = "name_and_surname"
            case age = "age_in_years"
        }
     }
     */

// 00:43 We instantiate it just like any other struct,
    // let person = Person(name: "Sudhir", age: 47)

// and to Encode it into a JSON object we use a JSON Encoder.
    // let encoder = JSONEncoder()

// we call the encode method which takes a new value whose type conforms to Encodable.
    // let json = try! encoder.encode(person)

// 00:55 And that's all there is to it. The result is encoded JSON data that we can set to the httpBody and method of a request.

// 01:04 The other thing to note is that the CodingKeys enum works both ways. So if we need the resulting JSON keys to differ from the Swift properties, we just add the CodingKeys enum - (see enum CodingKeys within struct Person above), hence the JSON encoder will take care of the rest.

// 01:16 Now that you have an overview of Encoding JSON data and making POST requests, it's time to practice those skills by making a POST request in Swift.

// MARK: text under the videos
/*
 It's time to use what you've learned to make a POST request in Swift! The following information comes from JSONPlaceholder web site: https://jsonplaceholder.typicode.com, a fake API for developers to play around with network requests.

 Base URL: https://jsonplaceholder.typicode.com Endpoint: /posts

 HTTP Method: POST
 
 JSON Request Body (keys and value types)
	
    userId: (Int)
    title: (String)
    body: (String)
 
 Follow the steps in the workspace below, and if the request is successful, a JSON response should be printed.
 */

import CoreFoundation

// create a Codable struct called "POST" with the correct properties
struct Post: Codable {
    let userId: Int
    let title: String
    let body: String
}

// create an instance of the Post struct with your own values
let post = Post(userId: 7, title: "bicyklovaDorucovatelska", body: "BD")

// create a URLRequest by passing in the URL
var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts") ?? URL(fileURLWithPath: "nil"))

// set the HTTP method to POST
request.httpMethod = "POST"

// set the HTTP body to the encoded "Post" struct
request.httpBody = try! JSONEncoder().encode(post)

// set the appropriate HTTP header fields
request.addValue("application/json", forHTTPHeaderField: "Content-Type")

// HACK: this line allows the workspace or an Xcode playground to execute the request, but is not needed in a real app
let runLoop = CFRunLoopGetCurrent()

// task for making the request
let task = URLSession.shared.dataTask(with: request ) {data, response, error in
    print(String(data: data!, encoding: .utf8) ?? "")
    // also not necessary in a real app
    CFRunLoopStop(runLoop)
}
task.resume()
// not necessary
CFRunLoopRun()



//: [Next](@next)
