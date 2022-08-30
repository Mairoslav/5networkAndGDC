//: [Previous](@previous)
//: ### Error Handling Summary
//: Below, options for handling errors are summarized.
//:
//: To summarize, there are four (4) ways to deal with errors:
//: **1. Handle Error with `Do`-`Catch`**
//:
import Foundation

print("1. HANDLE ERROR WITH `Do`-`Catch`")

func readFileIntoStringDoCatch(fileName: String, fileExtension: String) {
    if let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
        do {
            let content = try String(contentsOf: fileURL, encoding: .utf8)
            print(content)
        } catch {
            print("... error handled immediately!")
        }
    }
}

// readFileIntoStringDoCatch(fileName: "swift", fileExtension: "txt")
readFileIntoStringDoCatch(fileName: "swift", fileExtension: "png")

//: **2. Convert Error to Optional with `try?`**
//:

print("2. CONVERT ERROR TO OPTIONAL WITH `try?`")

func readFileIntoStringOptional(fileName: String, fileExtension: String) {
    if let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
        if let content = try? String(contentsOf: fileURL, encoding: .utf8) {
            print(content)
        } else {
            print("could not read contents of file into string")
        }
    }
}

// readFileIntoStringOptional(fileName: "swift", fileExtension: "txt")
readFileIntoStringOptional(fileName: "swift", fileExtension: "png")

//: **3. Ignore Error with `try!`**
//:

print("3. IGNORE ERROR WITH `try!")

func readFileIntoStringOrCrash(fileName: String, fileExtension: String) {
    if let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
        let content = try! String(contentsOf: fileURL, encoding: .utf8)
        print(content)
    }
}

readFileIntoStringOrCrash(fileName: "swift", fileExtension: "jpg")
// readFileIntoStringOrCrash(fileName: "swift", fileExtension: "txt")

//: **4. Propagate the Error**
//:

// print("4. Propagate the Error")

print("4. PROPAGATE THE ERROR")

func readFileIntoStringOrPropagate(fileName: String, fileExtension: String) throws {
    if let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
        let content = try String(contentsOf: fileURL, encoding: .utf8)
        print(content)
    }
}

do {
    try readFileIntoStringOrPropagate(fileName: "swift", fileExtension: "png")
} catch {
    print("the error was propagated to me, and I handled it!")
}

/*
 lesson 10. Displaying errors to Users
 
 User-Facing Errors
 Most users are not developers. Even if they were, they may not be familiar with the kinds of errors an app can generate. Therefore, be mindful of how you display errors to users. Try translating an error into a language that users can understand, and act upon. For example, if an image download fails because of a network failure, then ask the user to try again when they are on a stable network.
 */

/*
do {
    let image = try downloadImage()
    displayImage(image)
} catch {
    // an actionable, user-friendly alert
    showAlert("Image cannot be downloaded. Ensure you are on a stable network, and try again.")

    // a confusing, non-actionable alert (ex. "Request failed. Partial data. Status code 4xx.")
    showAlert("\(error)")
}
*/
 
//: [Next](@next)
