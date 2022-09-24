//: [Previous](@previous)

// MARK: 4. Storing URLComponents

import Foundation

// 00:00 So we have our URLComponents and just work fine, still we can improve it. Right now we have a lot of literal values stored diretly in the properties. This makes it hard to reuse these values throughout the code, and it is really likely we could make typos anytime we type important String by hand.

// 00:25 Instead let's create a centralized place where we can store and reference these. There are two really good options for this:
        // 1. structs
        // 2. enums

// Both are commonly used for this purpose.

// MARK: 1. Using struct
/*
 We can create a stuct to store bits of information that are going to be common to all App Store URLs. Let's call it AppStore
 */

struct AppStore {
    // 00:54 Inside the struct we can create static properties to hold their values like this. Static means that this is a property on the struct type itself. So we do not have to create instances of the struct to use it.
    static let scheme = "https"
    static let host = "itunes.apple.com"
    static let udacityPath = "/us/app/udacity/id819700933"
    
    // call the enum ParameterKey and the raw value is going to be String
    enum ParameterKey: String {
        case mediaType = "mt"
        // 02:00 We also do not want to get the values wrong, so let's create another enum to hold all the possible values for this field. We can call it MediaType -  see line 32.
    }
    
    enum MediaType: String {
           case music = "1", // 02:11 I fill these up so I know that "1" is music... "8" is mobileApps...
           podcasts = "2",
           audiobooks = "3",
           tvShows = "4",
           musicVideos = "5",
           movies = "6",
           iPodGames = "7",
           mobileApps = "8",
           ringTones = "9",
           iTunesU = "10",
           ebooks = "11",
           desktopApps = "12"
           // 02:20 Even though these are integer values, we only use them as part of URLs Strings, so it's more convenient to store them as Strings in our app. We could also use a struct here, but remember that enums with raw values only have one type. So we know that the value of any case from either of these enums is a String. The goal is to make our code organized as much as possible.
       }
}

// 01:10 We can now substitute our values to use the struct static properties like this.

var udacityAppURL = URLComponents()
udacityAppURL.scheme = AppStore.scheme
udacityAppURL.host = AppStore.host
udacityAppURL.path = AppStore.udacityPath

udacityAppURL.queryItems = [URLQueryItem(name: "mt", value: "300")]

print(udacityAppURL)

// 01:15 Now the path ends query are going to vary across URLs. For this we need a way to represent options, and that's where enums come in play.

// 01:22 Let's look at the query line, the "mt" represents a MediaType, and "8" is the type representing mobile apps. "mt" is what we call a ParameterKey. All this information comes from reading the documentation for the network data your app is using, and we will talk about it more in next lesson.

// 01:45 Let's make an enum to store all the parameter keys for our queries, so that we do not type this wrong. We will put this enum right inside of struct - check line 27.

udacityAppURL.queryItems = [URLQueryItem(name: AppStore.ParameterKey.mediaType.rawValue, value: AppStore.MediaType.mobileApps.rawValue)]

print(udacityAppURL)

// 02:45 Now we can compose the query item without having to type literals. It may seem a bit word here to read, but believe me there's no bigger wasted time than spending hours debugging your code and realizing the problem was only a simple typo. 03:02 By organizing the code like this, it will be easier to find all the URL parts helping to avoid mistakes and keeping our code cleaner.

// 03:12 The whole AppStore struct can live in its own file, helping us keep the different parts of our application logic separate and organized. We'll see more of this in the next lesson when we start working with more complex web services. For now, I just want you to recognize the best practice is to separate our these values from the rest of our code. All right, it is time for you to get some practice forming URLs yourself.

// MARK: exercise - Let's revisit the code for the Google search URL. Notice how there's now a struct called GoogleSearch with static properties for different parts of the URL, but right now, they're empty strings. Your task is to give these constants values, and then use these values in-place of the hardcoded values for each part of the URL.

// move the hardcoded values into the GoogleSearch struct

struct GoogleSearch {
    static let scheme = "https"
    static let host = "google.com"
    static let path = "/search"
    static let queryName = "query"
    static let querySearchTerm = "udacity"
}

var site = URLComponents()

// then modify the code to use the constants in the GoogleSearch struct

site.scheme = GoogleSearch.scheme
site.host = GoogleSearch.host
site.path = GoogleSearch.path
site.queryItems = [URLQueryItem(name: GoogleSearch.queryName, value: GoogleSearch.querySearchTerm)]

print(site.url ?? "")

//: [Next](@next)
