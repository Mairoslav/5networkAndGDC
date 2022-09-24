//: [Previous](@previous)

import Foundation // * URL components is a part of the foundation framework

// MARK: 3.1. URLComponents
/* https://github.com/udacity/ios-nd-networking/blob/6d5e2f72e511e0ebc3234bf6a33462dfe689813e/URLPlayground.playground/Pages/URLComponents.xcplaygroundpage/Contents.swift
*/

// 00:33 * URL components is a part of the foundation framework, so we will need to import that at the top, hence let's copy and paste the URL String for the Udacity app in the App Store.

let urlString = "https://itunes.apple.com/us/app/udacity/id819700933?mt=8"

// 00:45 Now let's first try constructing a URL components using the same technique that we did with the URL, just parsing in the URL String to its initializer.

let urlComponents = URLComponents(string: urlString) // NOTE: vs 2. URL here instead of URL(string: ...) we use URLComponents(string: ...)

// 00:55 Same as before, the initializer returns an optional (option + click on let urlComponents), so we will need to unwrap it to see whether or not we were successful.

if let urlComponents = urlComponents {
    // And inside of here we will we will print out each of the parts again and that worked perfectly well.
    print("scheme:\t\t\(String(reflecting: urlComponents.scheme))")
    print("user:\t\t\(String(reflecting: urlComponents.user))")
    print("password:\t\(String(reflecting: urlComponents.password))")
    print("host:\t\t\(String(reflecting: urlComponents.host))")
    print("port:\t\t\(String(reflecting: urlComponents.port))")
    print("path:\t\t\(String(reflecting: urlComponents.path))")
    print("query:\t\t\(String(reflecting: urlComponents.query))")
    print("fragment:\t\(String(reflecting: urlComponents.fragment))")
}

// 01:12 So we can see that it has all the functionality that URL had in its respect but where it really adds functionality is in composing URLs from parts so let's try that next.

// 01:25 This time we will start completetly from scratch using the default initializer.

var udacityAppURL = URLComponents()

// 01:28 Now we can set the various properties directly on the URL components instance. URLComponents has properties for each URL components such as port and fragments. Unlike URL where these work -get only, we can both -get and -set these properties. So let's go ahead and set:

udacityAppURL.scheme = "https" // our scheme to https, ...
udacityAppURL.host = "itunes.apple.com"
udacityAppURL.path = "/us/app/udacity/id819700933"

// 01:58 So far so good, so we have arrived to the part that gave us trouble last time, the query. URLComponents has a .queryItems property which is an Array of URL query item. So let me set this equal to an Array and inside this Array, we'll create a new URL query item.

udacityAppURL.queryItems = [URLQueryItem(name: "mt", value: "8")] // 02:15 This is the struct used by URLComponents to represent a single query parameter consisting of a name and a value. Ready to test? Let's print out that URLComponents to see if it worked.

print(udacityAppURL) // 02:25 And yeah, it did work. It took the key and value that we gave it and properly added the question mark and equal sign between them without adding anything extra.

// Perfect so we can see how URLComponents makes it easy to construct a URL from its parts and that is going to be useful especially as we start working with more complex queries.

// 02:52 Now in this example, I hard-coded the Strings we needed like "mt" and "8". But as we heard, it's easy for developers to type this wrong. Let's look at where we can organize these values next, but first check your understanding of URLComponents in the exercise below.

/*
 MARK: quizQuestion1: Check out the documentation for URLComponents. Which of the following statements are true for URLComponents? Check all that apply.
 
    a) URLComponents is part of the Foundation framework
            // YES
    b) It has an initializer that takes a String argument and returns an optional URLComponents
            // YES check line 15
    c) It has an empty initializer
            // YES check line 35
    d) Its properties such as scheme and host are read-only
            // NO, check line 37 we can both -get and -set these properties
    e) Its .queryItems property allows you to add an Array URLQueryItem
            // YES to add queries, you use a [URLQueryItem] array
 
 Correct! URLComponents is part of the Foundation framework. You can instantiate it using a zero-argument intializer, and set its properties such as scheme and host directly. To add queries, you use a [URLQueryItem] array.
 */

/*
 MARK: task1: Now that you've seen how to build a URL from URLComponents, try using it to build a URL. The following components make up the URL of a Google search for "udacity".
 
    scheme: https
    host: google.com
    path: /search
    query: ?query=udacity
 
 Create a URLComponents and set the appropriate parts of the URL. Feel free to refer back to the video if you get stuck.
 */

// create a new URLComponents
var urlUdacity = URLComponents()

// set the scheme, host and path
urlUdacity.scheme = "https"
urlUdacity.host = "google.com"
urlUdacity.path = "/search"

// set the query, you'll need to create a new URLQueryItem
urlUdacity.queryItems = [URLQueryItem(name: "query", value: "udacity")]

print(urlUdacity)
print(urlUdacity.url ?? "default value if nil")

//: [Next](@next)
