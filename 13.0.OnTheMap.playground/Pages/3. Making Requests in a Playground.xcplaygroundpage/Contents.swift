//: [Previous](@previous)

import Foundation

// MARK: 3. Making Requests in a Playground
/*
 Making Requests in a Playground
 You are about to see examples of network requests that use the Parse and Udacity APIs. If you would like to experiment and run the requests in a Xcode Playground, then you'll need to do a little setup. Specifically, you need to tell the Playground to execute indefinitely. This gives the Playground the ability to continue its execution until the network request finishes and provides you with a response. Here is an example:
 */

import UIKit
import PlaygroundSupport

// this line tells the Playground to execute indefinitely
PlaygroundPage.current.needsIndefiniteExecution = true

let urlString = "http://quotes.rest/qod.json?category=inspire"

let url = URL(string: urlString)
let request = URLRequest(url: url!)
let session = URLSession.shared
let task = session.dataTask(with: request) { data, response, error in
    if error != nil { // Handle error
        return
    }
    print(String(data: data!, encoding: .utf8)!)
}
task.resume()

//: [Next](@next)
