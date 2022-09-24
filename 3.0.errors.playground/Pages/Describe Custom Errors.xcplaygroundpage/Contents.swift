//: [Previous](@previous)
//: ### Describe Custom Errors
//: Custom errors can add extra debugging information by implementing the `LocalizedError` and `CustomNSError` protocols.
//:

/*
 /// MARK: (1.) LocalizedError
 /// LocalizedError includes properties which should be used to provide localized information about an error.
 /// Describes an error that provides localized messages describing why
 /// an error occurred and provides more information about the error.
 MARK: public protocol LocalizedError : Error {

     /// A localized message describing what error occurred.
     MARK: public var errorDescription: String? { get }

     /// A localized message describing the reason for the failure.
     MARK: public var failureReason: String? { get }

     /// A localized message describing how one might recover from the failure.
     MARK: public var recoverySuggestion: String? { get }

     /// A localized message providing "help" text if the user requests help.
     MARK: public var helpAnchor: String? { get }
 }
 */

import Foundation

enum PurchaseError: Error {
    case invalidAddress
    case cardRejected
    case cartWeightLimitExceeded(Double)
    case insufficientStock(String)
}
//: `LocalizedError` includes properties which should be used to provide localized information about an error. Note, for brevity, all comments for `NSLocalizedString` are left empty. In practice, comments should provide sufficient context about a localized string for accurate translation.
//:
extension PurchaseError: LocalizedError { // protocol LocalizedError
    /// A localized message describing what error occurred.
    public var errorDescription: String? { // get block 1
        switch self {
        case .invalidAddress:
            return NSLocalizedString("invalid address", comment: "")
        case .cardRejected:
            return NSLocalizedString("card rejected", comment: "")
        case .cartWeightLimitExceeded:
            return NSLocalizedString("weight limit exceeded", comment: "")
        case .insufficientStock:
            return NSLocalizedString("insufficient stock", comment: "")
        }
    }
    
    /// A localized message describing the reason for the failure.
    public var failureReason: String? { // get block 2
        switch self {
        case .invalidAddress:
            return NSLocalizedString("address contained invalid or empty fields", comment: "")
        case .cardRejected:
            return NSLocalizedString("card number or csv code is invalid", comment: "")
        case let .cartWeightLimitExceeded(amount):
            return NSLocalizedString("weight limit was by exceeded by \(amount) kg", comment: "")
        case .insufficientStock:
            return NSLocalizedString("insufficient stock", comment: "")
        }
    }
    
    /// A localized message describing how one might recover from the failure.
    public var recoverySuggestion: String? { // get block 3
        switch self {
        case .invalidAddress:
            return NSLocalizedString("check address", comment: "")
        case .cardRejected:
            return NSLocalizedString("type correct data / renew card validity", comment: "")
        case .cartWeightLimitExceeded:
            return NSLocalizedString("remove items from parcel", comment: "")
        case .insufficientStock:
            return NSLocalizedString("added \"out of stock\" items to waitlist", comment: "")
        }
    }
    
    /// A localized message providing "help" text if the user requests help.
    public var helpAnchor: String? { // get block 4
        // for simplicity, using the recovery suggestion as the help anchor
        return recoverySuggestion
    }
}
//: Once an error implements `LocalizedError`, it can be casted into one.
//:
func makeBadPurchase() throws {
    // throw PurchaseError.invalidAddress
    // throw PurchaseError.cardRejected
    // throw PurchaseError.cartWeightLimitExceeded(1.2)
    throw PurchaseError.insufficientStock("empty basket")
}

do {
    try makeBadPurchase() // // a fictitious function that might throw an error
} catch let error as LocalizedError { /* cast error to `LocalizedError` */
    if let description = error.errorDescription { print(description) }
    if let failureReason = error.failureReason { print(failureReason) }
    if let recoverySuggestion = error.recoverySuggestion { print(recoverySuggestion) }
    if let helpAnchor = error.helpAnchor { print(helpAnchor) }
} catch {
    print(error)
}

//: MARK: (2.) CustomNSError
//: Recall, all errors extend from `NSError`. But, by default, the properties of `NSError`, like domain, have inferred values. To provide more accurate values for `NSError` properties, implement `CustomNSError`.

/*
 /// Describes an error type that specifically provides a domain, code,
 /// and user-info dictionary.
 MARK: public protocol CustomNSError : Error {

     /// The domain of the error.
     MARK: public static var errorDomain: String { get }

     /// The error code within the given domain.
     MARK: public var errorCode: Int { get }

     /// The user-info dictionary.
     MARK: public var errorUserInfo: [String : Any] { get }
 }
 */

extension PurchaseError: CustomNSError {
    /// The domain of the error.
    public static var errorDomain: String { // get block 1
        return "ErrorsInDaPlayground"
    }
    
    /// The error code within the given domain.
    public var errorCode: Int { // get block 2
        switch self {
        case .invalidAddress:
            return 100
        case .cardRejected:
            return 101
        case .cartWeightLimitExceeded:
            return 102
        case .insufficientStock:
            return 103
        }
    }
    
    /// The user-info dictionary.
    public var errorUserInfo: [String: Any] { // get block 3
        switch self {
        case let .cartWeightLimitExceeded(amount):
            return [
                "weightLimit": 100.0,
                "weightExceeded": amount
            ]
        case let .insufficientStock(items):
            return [
                "itemsOutOfStock": items
            ]
        default:
            return [:]
        }
    }
}

//: If an error implements `CustomNSError`, then when casted as a `NSError`, it will contain the values provided by the protocol implementation.

func attemptPurchase(withWeight weight: Double) throws {
    if weight > 100 {        
        throw PurchaseError.cartWeightLimitExceeded(-1 * (100 - weight))
    } else {
        print("purchase succeeded!")
    }
}

do {
    try attemptPurchase(withWeight: 199.5) // a fictitious function that might throw an error
} catch let error as NSError { /* cast error to `NSError` */
    print(error.domain)
    print(error.code)
    print(error.userInfo)
} catch {
    print(error)
}
//: [Next](@next)
