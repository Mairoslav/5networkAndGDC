//: [Previous](@previous)
//: ### The Guard Statement
//: Guards specify conditions that must be true for execution to continue. These conditions may be thought of as *necessary preconditions*. The example below shows how guards could be used to make preflight checks before an airplane takes off. If a guard condition is not met, then its body is executed and the function returns immediately (early exit).
//:
func takeOff(passengersSeated: Bool, crewReady: Bool, runwayClear: Bool) {
    guard passengersSeated else { return }
    guard crewReady else { return }
    guard runwayClear else { return }
    // guard runwayClear == false else { return }
    print("✈️ Lifts off runway 1st airplane")
}

// the runway isn't clear, the airplane cannot take off
// note that one of the conditions is not held
// what we can expect that function will return early and print statement will not be executed
takeOff(passengersSeated: true, crewReady: true, runwayClear: false)

// MARK: all the preconditions are met, the 1st airplane takes off!
// i.e. all parameters for takeOff are set to true
// all the guard conditions are held and airplane lifts off the runway
takeOff(passengersSeated: true, crewReady: true, runwayClear: true)

//: - Callout(Watch Out!):
//: All guard conditions must be a Bool or resolve to a boolean value (true or false).
//:
// uncomment the function below to see Xcode complain that String ("true") is not a Bool
/*
 func takeOffGuardTypeFailure(passengersSeated: Bool, crewReady: Bool, runwayClear: Bool) {
    guard "true" else { return }
    guard crewReady else { return }
    guard runwayClear else { return }
    print("✈️ Lifts off runway")
 }
*/
//: 2:08 Guards can be combined together using commas. This can improve readability, especially in cases where conditions are related.

//:
func takeOffCombineGuards(passengersSeated: Bool, crewReady: Bool, runwayClear: Bool) {
    guard passengersSeated, crewReady, runwayClear else { return }
    print("✈️ Lifts off runway 2nd airplane")
}

// MARK: all the preconditions are met, the 2nd airplane takes off!
takeOffCombineGuards(passengersSeated: true, crewReady: true, runwayClear: true)

// 2:47 For any Guard, it's else block {...} must exit scope by using the keyword return, break, continue, or throw. ~ When an else block exits scope, it is called an "early exit".

//: - Callout(Watch Out!):
//: Guards must exit scope when conditions are not met. If a guard does not exit scope, then Xcode will complain.
//:
// uncomment the function below to see Xcode complain that the `passengersSeated` guard does not exit scope

/*
 func takeOffGuardFailure(passengersSeated: Bool, crewReady: Bool, runwayClear: Bool) {
 guard passengersSeated else { print("not exiting!") }
 guard crewReady else { return }
 guard runwayClear else { return }
 print("✈️ Lifts off runway")
 }
 */

//: Before returning, guards can execute additional code; here, a debug message is printed.
//:
func takeOffGuardWithCode(passengersSeated: Bool, crewReady: Bool, runwayClear: Bool) {
    guard passengersSeated, crewReady, runwayClear else {
        // 3:41 sometimes it is useful to execute little code right before exiting
        print("tell passengers there will be a delay / 3rd airplane")
        return
    }
    print("✈️ Lifts off runway 3rd airplane")
}

takeOffGuardWithCode(passengersSeated: false, crewReady: true, runwayClear: true)

//: - Callout(Watch Out!):
//: While combining guards can improve readability, it eliminates the opportunity for per-condition handling. When guards are combined, additional logic would need to be added to determine which condition failed. However, when guards are separated, it is easy to see exactly which condition failed.
//: 4:19 there is also trade-off. While multiple guards may improve debugging ability, you end up writing more code. Recommend to find balance based on amount of debugging information that you need. If you need to know exactly which condition caused a guard statement to fail, then split the things up in multiple guards, while if all conditions can be treated the same way, use the signle guard.
//:
func takeOffGuardsPrint(passengersSeated: Bool, crewReady: Bool, runwayClear: Bool) {
    guard passengersSeated else {
        print("passengers are not seated / 4th airplane")
        return
    }
    guard crewReady else {
        print("crew is not ready / 4th airplane")
        return
    }
    guard runwayClear else {
        print("runway is not clear / 4th airplane")
        return
    }
    print("✈️ Lifts off runway 4th airplane")
}

takeOffGuardsPrint(passengersSeated: true, crewReady: false, runwayClear: true)
//: If a guard returns immediately, then consider placing it on a single line. This isn't required, but it improves readability.
//:
func takeOffGuardsSingleLine(passengersSeated: Bool, crewReady: Bool, runwayClear: Bool) {
    // for simple guard statements, use a single line
    guard passengersSeated else { return }
    guard crewReady else { return }
    
    // 4:55 when a simple guard uses multiple lines, it wastes space... so better style as above
    guard runwayClear else {
        return
    }
    
    print("✈️ Lifts off runway 5th airplane")
}

takeOffGuardsSingleLine(passengersSeated: true, crewReady: true, runwayClear: true)
//: Generally, guard statements appear at the top of a function or block. But, depending on the situation, it may be appropriate to place a guard further down.
//:
func takeOffGuardInMiddle(passengersSeated: Bool, crewReady: Bool, runwayClear: Bool) {
    guard passengersSeated else { return }
    guard crewReady else { return }
    
    print("Passengers are seated and crew is ready. Once the final check for runwayClear is complete - that might take 10 minutes, we will be taking off / 6th airplane.")
    
    guard runwayClear else { return }
    
    print("✈️ Lifts off runway 6th airplane")
}

takeOffGuardInMiddle(passengersSeated: true, crewReady: true, runwayClear: true)
// takeOffGuardInMiddle(passengersSeated: true, crewReady: true, runwayClear: false)

// MARK: Quiz question 1:
// For the following invocation, a) will the function exit early or b) function will execute the print statement?
func bakeCake(ovenSet: Bool, cakeReady: Bool) {
    guard ovenSet, cakeReady else { return }
    print("time to bake!")
}

bakeCake(ovenSet: true, cakeReady: false)
// a) the function exit early. Correct, the function will exit early because ovenSet and cakeReady must both be true.


// MARK: Quiz question 2:
// For the following invocation, a) will the function exit early or b) function will execute the print statement?
func bakeCake(ovenTempInFahrenheit temp: Int, cakeReady: Bool, ovenEmpty: Bool) {
    guard temp >= 325, temp <= 350 else { return }
    guard cakeReady, ovenEmpty else { return }
    print("time to bake!")
}

bakeCake(ovenTempInFahrenheit: 340, cakeReady: true, ovenEmpty: true)
// b) function will execute the print statement. Nice work! The function finishes executing because all the necessary preconditions are held — the temperature falls between [325, 350], the cake is ready, and the oven is empty!

//: [Next](@next)
