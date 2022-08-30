//: [Previous](@previous)
//: ### The Many Faces of Try
//: The `try` keyword is used to execute error-prone code. If an error is generated while using the `try` keyword, it must be handled immediately or propagated.
//:
import Foundation

print("CASE_1:")

func printFileContents() {
    if let fileURL = Bundle.main.url(forResource: "swift", withExtension: "txt") {
        do {
            let content = try String(contentsOf: fileURL, encoding: .utf8)
            print(content)
        } catch {
            print("\(error)")
        }
    }
}

printFileContents()

print("CASE_2:")

//: Try comes in two other forms: `try?` and `try!`. `try?` executes error-prone code, and if any error is generated, then it is converted into an optional where the underlying value has the same type as the error-prone function or intializer's return type. This can simplify code, but the ability to analyze errors is lost.
//:
func printFileContentsTry() {
    if let fileURL = Bundle.main.url(forResource: "swift", withExtension: "png") {
        let content = try? String(contentsOf: fileURL, encoding: .utf8)
        print(content ?? "content is nil")
        
        // preferably, combine `if let` with `try?`; it's easier to read
        if let content = try? String(contentsOf: fileURL, encoding: .utf8) {
            print(content)
        } else {
            print("could not read contents of file into string")
        }
    }
}

printFileContentsTry()

print("CASE_3:")

//: - Callout(Watch Out!):
//: If `try?` is used to set an optional value, but the function that throws but doesn't return a type (returns `Void`), then Xcode will generate a warning.
//:
func readFileIntoString(fileName: String, fileExtension: String) throws {
    if let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
        let content = try String(contentsOf: fileURL, encoding: .utf8)
        print(content)
    }
}

// uncomment the following line to see Xcode generate a warning
// let unknownType = try? readFileIntoString(fileName: "swift", fileExtension: "png")
//: `try!` executes error-prone code while foregoing any opportunity to safely handle an error. If an error-prone function is called using `try!` and it fails, then the entire app or playground crashes.
//:
// try! should only be used if there is no risk of error; generally, this is not advised
if let fileURL = Bundle.main.url(forResource: "swift", withExtension: "txt") {
     let content = try! String(contentsOf: fileURL, encoding: .utf8)
     print(content)
}

// when try! is used and an error occurs, the executable (here, a playground) crashes
if let fileURL = Bundle.main.url(forResource: "swift", withExtension: "png") {
    print("try! reading \(fileURL.lastPathComponent) at your own risk")
    // uncommenting the following lines will crash the playground
    /*
    let content = try! String(contentsOf: fileURL, encoding: .utf8)
    print(content)
    */
}

print("CASE_4:")

/*
 8. The Many Faces of Try - TEST/QUIZ
 In the following example, what does try do?
 Note: The gradeTest(_:) function is purposefully hidden. You don't need to know how it is implemented to explain try.
 Things to think about: "try safely executes gradeTest(_:). If an error is generated, then it is printed in the catch block. If no error is generated, then a score is set and printed." — Jarrod"
 */

/*
struct MathTest {
    let answers: [Int]
}

func gradeTests(_ tests: [MathTest]) {
    do {
        for test in tests {
            let score = try gradeTest(test) // error: cannot find 'gradeTest' in scope
            print(score)
        }
    } catch {
        print("\(error)")
    }
}
*/

print("CASE_5:")

/*
 In the following example, what does try? do?
 Note: The gradeTest(_:) function is purposefully hidden. You don't need to know how it is implemented to explain try?.
 Things to think about: "try? executes gradeTest(_:). If an error is generated, then nil is returned, score is not initialized, and the print statement in the else block is executed. But, if no error is generated, then the score (Int) is safely unwrapped and printed." — Jarrod
 */

/*
struct MathTest {
    let answers: [Int]
}

func gradeTestsTry(_ tests: [MathTest]) {
    for test in tests {
        if let score = try? gradeTest(test) as Int { // error: cannot find 'gradeTest' in scope
            print(score)
        } else {
            print("unable to grade test")
        }
    }
}
*/

print("CASE_6:")

/*
 In the following example, what does try! do?
 Note: The gradeTest(_:) function is purposefully hidden. You don't need to know how it is implemented to explain try!.
 Things to think about: "try! forcefully executes gradeTest(_:). If an error is generated, then the program crashes. If no error is generated, then a score is set and printed." — Jarrod
 */
 
/*
struct MathTest {
    let answers: [Int]
}

func gradeTestsForce(_ tests: [MathTest]) {
    for test in tests {
        let score: Int = try! gradeTest(test) // cannot find 'gradeTest' in scope
        print(score)
    }
}
*/
 
//: [Next](@next)
