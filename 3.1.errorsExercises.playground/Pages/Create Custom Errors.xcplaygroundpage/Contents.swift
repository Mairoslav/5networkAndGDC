//: [Previous](@previous)
//: ### Create Custom Errors
//: - Callout(Exercise1):
//: Define a enum called `GrammarError` that implements the `Error` protocol and has two cases `passiveVoice` and `improperTense`. Each case should have an associated `String` value.

enum GrammarError: Error {
    case passiveVoice(String)
    case improperTense(String)
}

// let voiceIssue = GrammarError.improperTense("relax man")
// print(voiceIssue)

//: - Callout(Exercise2):
//: Define a function called `throwGrammarError` that immediately throws the error `GrammarError.passiveVoice`. (Optional) For the error's associated value, pass a string that contains an example of passive voice.

func throwGrammarError() throws { // fx throws error GrammarError.improperTense(String)
    throw GrammarError.improperTense("relax Man") // for error's associated value, String "relax Man" is passed
}

do { // via "do-catch" statement we call fx throwGrammarError()
    try throwGrammarError()
} catch {
    print(error)
}


//: [Next](@next)
