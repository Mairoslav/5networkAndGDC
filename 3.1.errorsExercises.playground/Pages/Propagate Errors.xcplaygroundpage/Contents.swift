//: [Previous](@previous)
//: ### Propagate Errors
//: - Callout(Exercise):
//: Modify `readFileContents` so that it propagates any errors thrown by the String initializer.
//:
import Foundation

/*
func readFileContentsOriginal(url: URL) {
    do {
        let content = try String(contentsOf: url, encoding: .utf8)
        print(content)
    } catch {
        // print(error)
        print("in this original example, error is not propagated")
    }
}

readFileContentsOriginal(url: Bundle.main.bundleURL)
*/

func readFileContentsPropagated(url: URL) throws { // add throws
    // in fx write what is in original written in do block
    let content = try String(contentsOf: url, encoding: .utf8)
    print(content)
}

// write separate "do-catch" block
do { // in do block write try and call fx
    try readFileContentsPropagated(url: Bundle.main.bundleURL)
} catch {
    // print(error)
    print("error is now propagated")
}

//: [Next](@next)
