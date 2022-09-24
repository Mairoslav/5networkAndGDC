//: [Previous](@previous)
//: ### Cleanup with Defer
//: The `defer` keyword is often coupled with error handling because it can be used to execute a block of code before an error-generating scope is exited.
//:
import Foundation

enum PurchaseError: Error {
    case invalidAddress
    case cardRejected
    case cartWeightLimitExceeded(Double)
    case insufficientStock(String)
}

func processOrder() throws {
    // throw PurchaseError.invalidAddress
    throw PurchaseError.cardRejected
}

print(".........................................func attemptPurchase()")

func attemptPurchase() {
    // before this function exits, execute this defer block
    defer {
        print("All Flash No Cash")
    }
    
    do {
        try processOrder()
    } catch {
        print(error)
    }
}

attemptPurchase()

//: - Callout(Watch Out!):
//: A defer block cannot contain code that changes the flow of control, like a break or return statement, or throwing an error.

print(".........................................func attemptPurchaseBadDefer()")

func attemptPurchaseBadDefer() {
    // before this function exits, execute this defer block
    defer {
        print("""
              The problem is that borrowing
              money to pay back more borrowed
              money that will oblige you in the
              future to borrow even more money
              doesn't sound kosher. Because it
              isn't
              """)
        // uncomment this break to see Xcode complain about flow of control
        // break // 'break' cannot transfer control out of a defer statement
    }
    
    do {
        try processOrder()
    } catch {
        print(error)
    }
}

attemptPurchaseBadDefer()

print(".........................................func attemptPurchaseWithMultipleDefers()")

//: Multiple defer blocks may be defined, but are executed in reverse order of when they appear.

func attemptPurchaseWithMultipleDefers() {
    // before this function exits, execute this defer block
    defer { print("then, close the secure purchase session") } // printed as 2nd
    defer { print("first, clear order") } // printed as 1st
    
    do {
        try processOrder()
    } catch {
        print(error)
    }
}

attemptPurchaseWithMultipleDefers()

/*
 
 MARK: 15. Outro
 
 Way to go! You’ve finished this lesson on errors. To summarize, here are a few important notes about errors:

 Errors...

 - can be generated even when code is correct
 - must be handled or propagated and subsequently handled
 
 - may be handled by a "do-catch" block
 - may be converted into optional values using "try?"
 - can crash a program if generated when using "try!"
 
 - are automatically converted to "NSError" in handling code
 - can be custom; just implement the "Error" protocol
 - can be described more precisely using "LocalizedError" and "CustomNSError"
 
 */
