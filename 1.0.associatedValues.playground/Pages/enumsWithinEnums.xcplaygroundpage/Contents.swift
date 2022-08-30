//: [Previous](@previous)

import Foundation

//: ### Enums within Enums
//: An associated value can be an enum that defines more associated values. This makes for some interesting combinations — enums within enums within enums...

enum ShirtSize {
    case XS, S, M, L, XL
}

enum Search {
    case forShirts(sizes: [ShirtSize])
    case forName(name: String)
}


let searchForML = Search.forShirts(sizes: [.M, .L])
let searchForHana = Search.forName(name: "Hana")

// snippet1
if case let Search.forShirts(sizes) = searchForML {
    for size in sizes {
        print("we are searching for shirts with sizes \(size)")
    }
}

// snippet2
if case let Search.forName(name) = searchForHana {
    print("oje what a nice name \(name)")
}

// In the snippet above, two search queries are defined: searchForML and searchForHana. searchForML is an example of an enum being used within an enum; the Search enum defines the type of search and an array of ShirtSize enums (the associated value) clarify the search.
        

//: [Next](@next)
