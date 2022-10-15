//: [Previous](@previous)

import Foundation

// MARK: 14. A Quick Detour on Closures

/*
 Before we can refactor our code for making a network request, there's one small thing to note about the "dataTask method" -
 https://developer.apple.com/documentation/foundation/urlsession/1410330-datatask
 
 // MARK: Escaping vs. Non-escaping
 The definition for the dataTask method looks like this, see "dataTask(with:completionHandler:)" in Developer Documentation, part Declaration (note that it is different for iOS, tvOS, watchOS vs macOS, macCatalyst):
 */

/*
func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    return // ...
}
*/

/*
 There are two parameters:
    1. a URL
    2. a closure that takes 3 parameters and returns void i.e (Data?, URLResponse?, Error?) -> Void.
 
 But what's that other part, @escaping???
 
 To understand the meaning of @escaping you need to know two terms: synchronous and asynchronous.
 */

// A) MARK: Synchronous
// A task is synchronous if each line of code waits for the previous line of code to finish. This makes sense, as most of the code you've written is synchronous. For example, updating UI elements.

someButton.isEnabled = false // First, the isEnabled property of someButton is changed.
someTextField.text = "Something's happening" // Then, the text of someTextField is changed
doSomething() //  And finally, doSomething() is called.
// All of these happen in order. The previous task must finish before the other can be executed.

// B) MARK: Asynchronous
// Something is asynchronous if two tasks run independently from one another. In other words, one task doesn't need the other task to finish in order to execute. The code might not even run in the order it's written! Take for example two functions that behind the scenes call dataTask to download a file.

downloadLargeImageFile()
downloadSmallImageFile()

//Which function finishes first?
// Well, like before, the functions are run in order, so downloadLargeImageFile() still finishes before downloadSmallImageFile().

// But what image finishes downloading first?
// We don't know! Each function calls dataTask() which means each image is downloaded on its own thread. Even though the functions are called in order, the threads run independently of one another, and we can't guarantee when each dataTask is finished. The large image could finish downloading first or the small one could.

// The one thing you need to know
// If you're making a function that takes a closure as a parameter (like dataTask does), ask is the code passed into the closure could run after this function is finished?

    // If yes, mark the closure with @escaping (asynchronous).
    // If no, do not mark the closure with @escaping

// In general, if you need to do something asynchronous like making a network request, then you'll need to mark it with @escaping. You'll see this in action as we refactor the code for making network requests.

//: [Next](@next)
