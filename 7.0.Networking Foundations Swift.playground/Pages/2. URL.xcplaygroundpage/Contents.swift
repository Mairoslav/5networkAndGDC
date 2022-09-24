//: [Previous](@previous)

import Foundation

// MARK: 2. URL

/*
 https://github.com/udacity/ios-nd-networking/blob/6d5e2f72e511e0ebc3234bf6a33462dfe689813e/URLPlayground.playground/Pages/URL.xcplaygroundpage/Contents.swift
 */

/*
 00:00 So our big goal is to fetch an image and show it in our app. Every HTTP request starts with URL. So let's start with finding a way to represent URLs in code.
 
 00:15 It turns out, there are actually a couple of different options for creating URLs in Swift. I have a new playground open, where we can try them out. I have copied the URL for the Udacity App in the AppStore and I have included a link below the video.
 */


// 00:30 Right now we'll just start as a string called URL String.

var urlString = "https://itunes.apple.com/us/app/udacity/id819700933?mt=8"
// urlString = "https://nonexisgtent.apple.com/us/app/udacity/dfdfd"

// 00:35 We still need to tell Swift that this is a URL specifically. There are a couple ways to do that. The first option is to use Swift's URL struct. URL has a initializer that accepts a String, so let's use it to convert this String into a URL.

// 00:52 Now not every String that you could provide as an argument will create a valid URL, so the initializer return an optional (option + click on url and will see "let url: URL?"). This in known as a failable initializer. If the initialization fails because the String is not a valid URL, then nil is returned.

let url = URL(string: urlString)

// 01:11 To see whether or not we were successful, we need to unwrap the results. Let's check the output and great, it is there - it prints URL: https://itunes.apple.com/us/app/udacity/id819700933?mt=8

if let url = url {
    print("URL: \(url)")
}

// 01:20 One cool thing about the URL struct is that it can actually give us more informatoion about all parts that make up the URL. In the last lesson, we learnt that the URL could be broken into components: scheme, host, path ... URL has a property of each of these. So let's list everything out: scheme, user, password, host ... fragment.

// 01:45 I am going to add some tabs, sot that this is readable. Depending on the font size you are using, you might find that you need a slightly different number of tabs than me. Now lots of these properties are optional (option + click on .scheme...).

if let url = url {
    print("scheme:\t\t\(String(reflecting: url.scheme))")
    print("user:\t\t\(String(reflecting: url.user))")
    print("password:\t\(String(reflecting: url.password))")
    print("host:\t\t\(String(reflecting: url.host))")
    print("port:\t\t\(String(reflecting: url.port))")
    print("path:\t\t\(String(reflecting: url.path))") // 01:58 notice that .path is the only one that is not an optional.
    print("query:\t\t\(String(reflecting: url.query))")
    print("fragment:\t\(String(reflecting: url.fragment))")
}

// 02:02 I used String(reflecting: ... ) to print the output without unwrapping it. This allows us to see what's really in there and also makes the output cleaner. So we have seen that the URL struct can take a fully formed URL and break it up into its components. However, in practice, when when we are making network requests, we're not going to be taking URL's apart, instead we're going to be putting them together, usually we are using the same scheme and host at the beggining of our requests and just add a different path or queries to the end.

// 02:40 So let's flip this around and take a look at constructing a URL from its parts. Here I make a String that holds the base iTunes URL and we'll turn it into URL.

let iTunesBaseURLString = "https://itunes.apple.com/"
var simpleURL = URL(string: iTunesBaseURLString)

// 02:50 Now let's try adding the first piece of the path onto it. The URL struct has a lot of methods for working with URLs. Now we can use the .append(path: "XString"). Note that in Udacity lesson it is .appendPathComponent("XString"), however XCode warns us that this is going to be depreciated*, so instead suggests us to use .append(path: "XString"), I did rewrite code accordingly.

// simpleURL?.appendPathComponent("us") // *is going to be depreciated, so instead do use .append(path: "XString")
simpleURL?.append(path: "us") // /us
print("simpleURL: \(simpleURL!)" ) // 03:10 Great, appends path component even added the preceding slash / for us. Let's go ahead and add the remaining parts of the path:
simpleURL?.append(path: "app") // /app
simpleURL?.append(path: "udacity") // /udacity
simpleURL?.append(path: "id819700933") // /id819700933
print("simpleURL: \(simpleURL!)" ) // 03:24 so far it seems to be going according to plan, there is just one more part to add, and that is the query "mt=8" (note that ? is not part of the path. It is a separator between path and query, check: https://stackoverflow.com/questions/53955144/swift-url-appendingpathcomponent-converts-to-3f)
// MARK: oouu
simpleURL?.append(path: "?mt=8") // 03:37 oouu, that's not what we wanted, why String symbol ? here is printed as %3F in console? plus we do not need to print slash / now.
print("simpleURL: \(simpleURL!)" )

// 03:48 This is known as a percent encoding. This allows us to use characters not normally allowed in URLs. Similar to escape characters and Swift Strings, and there is an added slash / that we do not need. Instead we needed to stay as questionmark (?) - what to do?

// 04:05 Whell it turn that questionmark is in fact a valid character when adding "query" parameters to the URL but not for "path" components like we added.

// 04:17 However, Swift's URL structs do not have any methods to add query parameters. We can add to it path just fine, but we cannot add queries or fragments. So here we are running up against limitations of Swift's URL struct.

// 04:30 It works pretty well for URLs that we constructed fully formed from String, but now we need to build URLs entirely from parts, especially when those parts include queries. Fortunately, Swift has a second class for creating URLs, that's a little better suited for our needs. Let's look at that next.

// MARK: question1: We'll still be using URL throughout this course to construct URLs from fully formed strings. Take a trip to the URL documentation: https://developer.apple.com/documentation/foundation/url and select which of the following statements are true for URL?

/*
    a) It is included in Foundation framework
    b) It has an initializer that accepts a String parameter and returns an optional URL
    c) Its properties, such as scheme and host are read only
    d) Its appendPathComponent / .append(path: "XString") function allows you to add queries and fragments
 */

// a, b, c are TRUE. Correct! URL is part of Foundation, and can be initialized with a string: let optionalURL = URL(string: "possibleURL"). Its properties, such as host and path, are read-only. You can use .appendPathComponent / .append(path: "XString") to add to its path, but that won't work with queries and fragments

// MARK: question2: Alright, now it's your turn to build a URL! Follow the instructions below to convert the string into a URL and then add the path component. Click "Run Code" to test.

// Task 1: create a valid URL
let website = "http://udacity.com"
var url1 = URL(string: website)
print(url1!)

// Task 2: append an "ios" path component to the URL
url1?.append(path: "ios")
print(url1!)

//: [Next](@next)
