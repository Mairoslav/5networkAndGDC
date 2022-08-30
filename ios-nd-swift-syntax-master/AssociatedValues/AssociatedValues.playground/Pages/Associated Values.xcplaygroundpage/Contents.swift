//: [Previous](@previous)
//: ### Associated Values
//: Associated values are defined alongside enum cases. Associated values are not required; some enum cases may have an associated value while others do not. In the example below, `LibraryFee` has three cases with associated values and a case without an associated value.
//:
enum LibraryFee {
    case overdueBook(Int)
    case lostBook(Double)
    case lostLibraryCard(Int)
    case annualDues
}

let fee = LibraryFee.overdueBook(4)
var dues = LibraryFee.annualDues

//: It can be very helpful to name associated values so that their intent is easily understood.
//:
enum DescriptiveLibraryFee {
    case overdueBook(days: Int)
    case lostBook(price: Double)
    case lostLibraryCard(timesLost: Int)
    case annualDues
}

let weekLateFee = DescriptiveLibraryFee.overdueBook(days: 7)
let youPayForLostBook = DescriptiveLibraryFee.lostBook(price: 23.7)

//: Associated values are actually tuples. Therefore, an associated value can contain mutliple values. Recall from [Apple's documentation](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID329) that tuples are multiple values grouped into a single compound value.
//:
import UIKit

enum ImageFilter {
    case sepia
    case verticalGradient(from: UIColor, to: UIColor) // 3:49 tuple of type (UIColor, UIColor)
    case horizontalGradient(from: UIColor, to: UIColor)
    case sketch(penThickness: Double?)
}

let fadeToBlack = ImageFilter.horizontalGradient(from: .gray, to: .black)
print(fadeToBlack)
//: - Callout(Watch Out!):
//: If all enum cases have an associated value of the same type, and it is static, then you might consider using a raw value instead.
//:
// the associated values for `AudioRateAssociated` should be raw values
enum AudioRateAssociated {
    case slow(value: Int)
    case normal(value: Int)
    case fast(value: Int)
    case custom(value: Int)
}

enum AudioRateRaw: Int {
    case slow, normal, fast, custom
}

// MARK: Quiz

// 1. Will Xcode generate a compile-time error or warning for the following code?
enum LibraryFeee {
    case overdueBook(Int)
    case lostBook(Double)
    case lostLibraryCard(Int)
    case annualDues
}

// let fee = LibraryFee.overdueBook(1.0)
let feee = LibraryFeee.overdueBook(1) // corrected

// yes Xcode will generarte an error or warning Xcode, because type for case overdueBook is defined as Int, not as Double. So if 1.0 error: "Cannot convert value of type 'Double' to expected argument type 'Int'"

// 2. Will Xcode generate a compile-time error or warning for the following code?

enum SillyLetter {
    case a(String, Int)
    case b(Int, String)
    case c(Int, Int, Int)
    case d(Double, String)
}

let letter = SillyLetter.d(1, "hello")

// Xcode generate a compile-time error or warning 

//: [Next](@next)
