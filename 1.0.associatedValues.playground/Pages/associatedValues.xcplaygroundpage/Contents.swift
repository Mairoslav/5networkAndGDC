//: [Previous](@previous)

import Foundation

//: ### Associated Values
//: Associated values are defined alongside enum cases. Associated values are not required; some enum cases may have an associated value while others do not. In the example below, `LibraryFee` has three cases with associated values and a case without an associated value.

enum LibraryFee {
    case overdueBook(Int)
    case lostBook(Double)
    case lostLibrarycard(Int)
    case anualDues
}

//: It can be very helpful to name associated values so that their intent is easily understood.

enum DescriptiveLibraryFee {
    case overdueBook(days: Int)
    case lostBook(price: Double)
    case lostLibrarycard(timesLost: Int)
    case anualDues
}

var weekLateFee = DescriptiveLibraryFee.overdueBook(days: 7)
let feePerOneOverdueDay = 10

// var toPay = weekLateFee * feePerOneOverdueDay // question: how to use this associated value as Int?

//: Associated values are actually tuples. Therefore, an associated value can contain mutliple values. Recall from [Apple's documentation](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID329) that tuples are multiple values grouped into a single compound value.

import UIKit
/*
enum imageFilter {
    case sepia
    case verticalGradient(from: UIColor, to: UIColor) // 3:49 tuple of type (UIColor, UIColor)
    case horizontalGradient(from: UIColor, to: UIColor)
    case sketch(penThickness: Double?)
}

let fadeToBlack = imageFilter.horizontalGradient(from: .gray, to: .black)
print(fadeToBlack)
*/
//: Callout(Watch Out!) the difference between associated and raw values:
//: If all enum cases have an associated value of the same type, and it is static, then you might consider using a raw value instead.
// the associated values for `AudioRateAssociated` should be raw values

// however, if the value depends on the instance/case itself, then associated values are better, which is not the case here because all instances/cases are of type Int.
// unlike raw value, assiciated value is dynamic and it can take on a different value each time the enum case is instantiated. So you could have a slow audio rate with value of 2 or value of 3 ..., but in this case it does not make much sense, since each audio rate should have single static raw representation. So if you play at slow rate it plays one certain one value rate, normal at certain one value rate...

enum audioRateAssociated {
    case slow(value: Int)
    case normal(value: Int)
    case fast(value: Int)
    case custom(value: Int)
}

enum audioRateRaw: Int {
    case slow, normal = 1, fast, custom
}

// let normalAutioRateValue = audioRateRaw.normal.rawValue // question: how to get Int from associated value as here from raw value? Is it even possible?
// 0:42 summary


//: [Next](@next)
