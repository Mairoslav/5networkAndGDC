//: [Previous](@previous)
//: ### Describe Custom Errors
//: The following exercises will use the `GrammarError` enum and `throwGrammarError` function.
//:
import Foundation

enum GrammarError: Error {
    case passiveVoice(String)
    case improperTense(String)
}

func throwGrammarError() throws {
    // throw GrammarError.passiveVoice("boring voice")
    throw GrammarError.improperTense("stressed voice")
}

//: - Callout(Exercise1):
//: Extend `GrammarError` such that it implements the `LocalizedError` protocol. (Optional) Provide creative values for all `LocalizedError` properties.

extension GrammarError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .passiveVoice:
            return "voice is monotonous"
        case .improperTense:
            return "voice is rigid"
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .passiveVoice:
            return "no reflection of emotions or no emotions"
        case .improperTense:
            return "person is stressed due to expectations about output"
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .passiveVoice:
            return "feel emotions and reflect them in your voice"
        case .improperTense:
            return "be here and now, observe, think, react as per your real self"
        }
    }
    
    public var helpAnchor: String? {
        switch self {
        case .passiveVoice:
            return "feel"
        case .improperTense:
            return "present"
        }
    }
}

//: - Callout(Exercise2):
//: Extend `GrammarError` such that it implements the `CustomNSError` protocol. (Optional) Provide creative values for all `CustomNSError` properties.

extension GrammarError: CustomNSError {
    
    public var errorCode: Int {
        switch self {
        case .passiveVoice:
            return 0
        case .improperTense:
            return 1
        }
    }
    
    public var errorUserInfo: [String : Any] {
        switch self {
        case .passiveVoice:
            return ["mono" : "oooo"]
        case .improperTense:
            return ["frozen" : "neck"]
        }
    }
    
    public static var errorDomain: String { // note static here
        return "domainErrorsInDaGrammarError"
    }
    
}

//: - Callout(Exercise3):
//: Call `throwGrammarError` casting any thrown error into an `NSError`. Then, print the error's localized description and the values of all its `NSError` properties.

do {
    try throwGrammarError()
} catch let error as NSError {
    print(error.code)
    print(error.userInfo)
    print(error.domain)
} catch {
    print(error)
}

//: [Next](@next)
