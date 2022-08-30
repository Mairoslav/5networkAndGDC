//: [Previous](@previous)
//: ### Guard Let Versus If Let
//: When optional values are used with `guard let` (or `guard var`) they are bound as non-optional values and available in the rest of the scope where the guard statement appears. This differs from how optionals work with `if let`. With `if let`, optionals are bound as non-optional constants, and they are only available in the body of the `if let` statement.
//:
func takeOff(passengersSeated: Bool, crewReady: Bool, runwayClear: Bool, crewLeader: String?, greeting: String?) {
    guard passengersSeated, crewReady, runwayClear else { return }
    guard let crewLeader = crewLeader else { return }
    
    // the crew leader - from left side of equal sign - is available throughout this function
    print("\(crewLeader): \"Takeoff checks complete!\"")
    
    // while the greeting is only available as a constant in the body of the if statement
    if let greeting = greeting {
        print("\(crewLeader): \"\(greeting)\"")
    }
    
    // here, the greeting is optional
    if greeting != nil {
        print("greeting = \(greeting!)")
    }
    
    print("✈️ Lifts off runway")
}

takeOff(passengersSeated: true, crewReady: true, runwayClear: true, crewLeader: "👩🏻 Natasha", greeting: "Hello all, we are t aking off in 3...2...1!")

// MARK: Outro

/*
 Great job! You’ve finished this lesson on guard statements, or guards. To summarize, here are a few important notes about guard statements:

 Guard statements...

    - check for conditions that must be held for execution to continue
    - can simultaneously check for conditions while safely unwrapping optionals
    - must exit scope if conditions are not held
    - use commas to separate multiple conditions
 */ 
