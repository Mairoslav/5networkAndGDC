//: [Previous](@previous)
//: ### Guards with Optionals
//: Guards can specify conditions involving optionals using the `guard let` syntax. `guard let` checks for the existance of a value (non-nil) while safetly binding and storing it into a constant. If the value is nil, then the condition fails. If the value is non-nil, then the condition is met and the value is stored and usable as a constant in the rest of the scope where the guard statement appears.
//:

// MARK: ........................................................................................

func takeOff(passengersSeated: Bool, crewReady: Bool, runwayClear: Bool, crewLeader: String?) {
    guard passengersSeated, crewReady, runwayClear else { return }
    
    // check: is the crew leader non nil?
    guard let crewLeaderConstant = crewLeader else { return }

    // the crew leader is available throughout this function
    print("\(crewLeaderConstant): \"Takeoff checks complete!\"")
    print("✈️ Lifts off runway 1")
}

takeOff(passengersSeated: true, crewReady: true, runwayClear: true, crewLeader: "👩🏻‍✈️ Anastasia")

// MARK: ........................................................................................

//: - Callout(Watch Out!):
//: Names defined in a guard condition are not available in the guard's body.
//:
func takeOffNameInBody(passengersSeated: Bool, crewReady: Bool, runwayClear: Bool, crewLeader: String?) {
    guard passengersSeated, crewReady, runwayClear else { return }
    guard let crewLeaderConstant = crewLeader else {
        // print("\(crewLeaderConstant) is nil") /* cannot use crewLeaderConstant here! */
        return
    }
    
    print("\(crewLeaderConstant): \"Takeoff checks complete!\"")
    print("✈️ Lifts off runway 1.1")
}
//: - Callout(Watch Out!):
//: It is not possible to reuse a name from a `guard let` statement in the same local scope.

takeOffNameInBody(passengersSeated: true, crewReady: true, runwayClear: true, crewLeader: "👩🏻 Mellanie")

// MARK: ........................................................................................

func takeOffNameConflict(passengersSeated: Bool, crewReady: Bool, runwayClear: Bool, crewLeader: String?) {
    guard passengersSeated, crewReady, runwayClear else { return }
    guard let crewLeaderConstant = crewLeader else { return }
    
    // let crewLeaderConstant = "James" /* "crewLeader" has already been used in the guard statement */
    print("\(crewLeaderConstant): \"Takeoff checks complete!\"")
    print("✈️ Lifts off runway 1.2")
}
//: It is also possible to use `guard var`, but it is less common. With `guard var` the optional is bound and able to be changed.

takeOffNameConflict(passengersSeated: true, crewReady: true, runwayClear: true, crewLeader: "👩🏻 Lea")

// MARK: ........................................................................................

func takeOffGuardVar(passengersSeated: Bool, crewReady: Bool, runwayClear: Bool, crewLeader: String?) {
    guard passengersSeated, crewReady, runwayClear else { return }
    guard var crewLeaderVariable = crewLeader else { return }
    
    // modify the crew leader
    crewLeaderVariable = crewLeaderVariable.uppercased()
    
    print("\(crewLeaderVariable): \"Takeoff checks complete!\"")
    print("✈️ Lifts off runway 2")
}

takeOffGuardVar(passengersSeated: true, crewReady: true, runwayClear: true, crewLeader: "👩🏻‍✈️ Briggitte")
//: A `guard let` or `guard var` statement can check if an optional is non-nil while ignoring its value. Logically, it is like saying "a value must exist, but I don't care what it is."

// MARK: ........................................................................................

func takeOffGuardIgnore(passengersSeated: Bool, crewReady: Bool, runwayClear: Bool, crewLeader: String?) {
    guard passengersSeated, crewReady, runwayClear else { return }
    // ignore the value, just make sure it exists
    guard var _ = crewLeader else { return }

    print("Takeoff checks complete!, says Olivia that whose name is ignored by guard var _ =")
    print("✈️ Lifts off runway 3")
}

takeOffGuardIgnore(passengersSeated: true, crewReady: true, runwayClear: true, crewLeader: "👩🏻‍✈️ Olivia")
//: Often, developers will unwrap an optional using the same name for simplicity and conciseness. If the unwrapping succeeds, then the name refers to a non-optional value for the rest of the scope where it was unwrapped.

// MARK: ........................................................................................

func takeOffReuseName(passengersSeated: Bool, crewReady: Bool, runwayClear: Bool, crewLeader: String?) {
    guard passengersSeated, crewReady, runwayClear else { return }
    
    // check: is the crew leader non nil?
    guard let crewLeader = crewLeader else { return }
    
    // the crew leader is available throughout this function
    print("\(crewLeader): \"Takeoff checks complete!\"")
    print("✈️ Lifts off runway 4")
}

takeOffReuseName(passengersSeated: true, crewReady: true, runwayClear: true, crewLeader: "👩🏻‍✈️ Yvonne")

//: [Next](@next)
