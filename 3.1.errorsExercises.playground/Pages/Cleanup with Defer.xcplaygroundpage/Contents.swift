//: [Previous](@previous)
//: ### Cleanup with Defer
//: The following exercises will use the `GrammarError` enum and the `analyzeSentenceGrammar` and `checkSentence` functions.
//:
import Foundation

enum GrammarError: Error {
    case passiveVoice(String)
    case improperTense(String)
}

func analyzeSentenceGrammar() throws {
    throw GrammarError.passiveVoice("The test was taken by the student.")
}

func checkSentence() { // print statements executed in reversed order
    defer { print("3. play editing sound") } // executed as 3rd
    defer { print("2. reformat sentence for display") } // executed as 2nd
    defer { print("1. highlight any problems") } // executed as 1st
    
    do {
        try analyzeSentenceGrammar()
    } catch {
        print(error)
    }
}

//: - Callout(Exercise):
//: In what order are the print statements in `checkSentence` executed?
//: Answer: in reversed, check comments above

checkSentence()
