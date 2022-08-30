//: [Previous](@previous)
//: ### Create Custom Errors
//: To create a custom error, define a type that inherits from the `Error` protocol. Often, enums are used for this purpose.
//: Command+click on Error > choose jump to definition 0:25, we specify the protocol conformatce below by writing ... : Error ...
enum SimplePurchaseError: Error { // enums are used to define a type that inherits from Error protocol
    case invalidAddress
    case cardRejected
    case cartWeightLimitExceeded
    case insufficientStock
}

func makeBadPurchase() throws { // fx throws an error when called
    throw SimplePurchaseError.cardRejected // throw a custom error as per enum case
}

// to call this fx we can use any of the try variance, or propagate the error, and for this example we just wrap everything in a "do - catch" statement and we use normal "try"

do {
    try makeBadPurchase()
} catch {
    print(error) // prints "cardRejected", as defines by one of cases in Error enum
}
//: 1:29 When using an enum to define a custom error, use "associated values (AVs')" to add helpful debugging information.

enum ComplexPurchaseError: Error { // modified xxxPurchaseError, now xxx = Complex instead of Simple, because using "associated values (AVs')"
    case invalidAddress
    case cardRejected
    case cartWeightLimitExceeded(Double)
    case insufficientStock(String)
}

func attemptPurchase(withWeight weight: Double) throws {
    if weight > 100 {
        // throw a custom error with an associated value
        // 1:57 throwing an error with associated value is like defining any enum case with associated values, and 2:16 and we are going to include the amount by which that limit was exceeded
        throw ComplexPurchaseError.cartWeightLimitExceeded(-1 * (100 - weight))
    } else { // 2:20 otherwise we will print below String statement"
        print("purchase succeeded!")
    }
}

// 02:01 So I have gone ahead and created this function called attemptPurchase and it provides more realistic use of custom error.
// 2:24 then we call error-prone fx using a "do - catch" block, and our "try" statement and instead of just catching any error, we can use a more specific catch statement and we will cast the error into a ComplexPurchaseError - and that will allow us to extract the associated value for the .cartWeightLimitExceeded(weight) error

do {
    try attemptPurchase(withWeight: 125.6)
} catch let error as ComplexPurchaseError {
    switch error {
    case let .cartWeightLimitExceeded(weight): /* extract the associated value */
        print("purchase failed. weight exceeds limit by: \(weight)") // 2:55
    default:
        print(error)
        break
    }
} catch {
    // 2:44 after the specific catch statement we'll keep a catch-all and that's just good practice in case the fx changes to throw other kinds of errors.
    print(error)
}

// QUIZ - Create Custom Errors
// For the next question, consider the following code snippet:

enum InputError: Error {
    case invalidKey(keycode: Int)
    case noController
    case unknownInputDevice
}

func handleInput() throws -> Bool {
    do {
        try handleInput()
        // try processInput() // not shown; can throw any possible InputError
    } catch InputError.invalidKey(let code) {
        print("invalid key \(code)")
    } catch InputError.unknownInputDevice {
        print("unknown input device")
    }

    return true
}

try? handleInput()

// Will Xcode generate a compile-time error or warning for the above code?
// a) Xcode generates a compile-time error or warning
// a) is FALSE, Because handleInput() is marked as throws, any errors it does not handle (like InputError.noController) are propagated to the call site. Also, because handleInput() is invoked using try?, any error is converted into an optional bool and can be ignored.

// b) Xcode does not generate a compile-time error or warning
// b) is TRUE, Got it! handleInput() handles some errors while propagating others to the call site. Because try? is used, any error that is thrown is converted into an optional bool and can be ignored.

//: [Next](@next)
