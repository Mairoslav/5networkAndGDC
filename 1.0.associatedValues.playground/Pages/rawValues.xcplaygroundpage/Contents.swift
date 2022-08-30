//: [Previous](@previous)

import Foundation
import Darwin

// Prereq: Associated Values

/*
 “Associated values, raw values, rawhide, what’s the difference?”
 
 Enums can have raw values and associated values. A raw value is a string, character, or number (integer or floating-point) that can represent an enum case.
 */

// Position enum and uses type annotation (here Int) to specify that all cases must have a raw integer value
enum Position: Int { // ": Int" is the type annotation
    case first = 1 // Then, for each case, a raw integer value is explicitly defined after the case name.
    case second = 2
    case third = 3
    case fourth = 4
    // enumCase xz = rawValue
}


// MARK: Raw Value to Enum

/*
 Raw values enable developers to convert values into enum cases, and vice versa. Let’s keep working with the Position enum.
*/

// To convert an enum case into its raw value, use its rawValue property:
let myPosition = Position.first
let myPositionNumber = myPosition.rawValue
print(myPositionNumber) // prints "1"

// To convert a raw value to its respective enum case, use the initializer that takes a rawValue argument.

let rivalPositionNumber = 4
let rivalPosition = Position(rawValue: rivalPositionNumber)
print(rivalPosition as Any)
print(rivalPosition == .first)
print(rivalPosition == .second)
print(rivalPosition == .third)
print(rivalPosition == .fourth)

// MARK: Since there is no guarantee that a raw value has a corresponding case, any attempt to create an enum from a raw value will return an optional. To be safe, use if let to create enums from raw values.

var randomNumber = 7

if let hugosPosititon = Position(rawValue: randomNumber) {
    print("Hugo's position is \(hugosPosititon)")
} else {
    print("Hugo's position is out of positions' range within enum Position")
}

// MARK: Implicit Raw Values

/*
In certain situations, the Swift compiler can infer raw values for enum cases. If an enum uses raw string values, then each case is implicitly assigned a raw string value equal to the case's name.
*/

enum audioRate: String {
    case slow, normal, fast
}

print(audioRate.normal.rawValue) // here and also in other cases it works also without writing .rawValue

// ***If an enum uses raw integer values, then the compiler assigns zero to the first case, and increases the raw value for subsequent cases by one.

enum indexedWhenEnumInt: Int {
    case zero = 10_000, one = 1, two = 2, three, four, five, six, seven = 7
}

print(indexedWhenEnumInt.zero)
print(indexedWhenEnumInt.zero.rawValue)
print(indexedWhenEnumInt.two)
print(indexedWhenEnumInt.three)
print(indexedWhenEnumInt.three.rawValue) // ***when I do not provide rawValue to case, it is assigned by swift as per indexed order from 0 to ...
print(indexedWhenEnumInt.seven)

// It is also possible to define an enum with implicitly and explicitly defined raw values; all implicitly defined raw integer values will be one greater than the previous raw integer value. If no previous raw integer value exists, then the compiler will assign zero to the enum case.

enum indexedWhenEnumIntB: Int {
    case zero, one, three = 333, four, five, six, seven = 777, eight = 888, nine
}

print(indexedWhenEnumIntB.zero.rawValue)
print(indexedWhenEnumIntB.one.rawValue)
print(indexedWhenEnumIntB.three.rawValue)
print(indexedWhenEnumIntB.four.rawValue)
print(indexedWhenEnumIntB.five.rawValue)
print(indexedWhenEnumIntB.six.rawValue)
print(indexedWhenEnumIntB.seven.rawValue)
print(indexedWhenEnumIntB.eight.rawValue)
print(indexedWhenEnumIntB.nine.rawValue)

// You can mix and match implicit and explicit raw string values too:

enum axis: String {
    case x // also note that when cases under each other, have to use no commas !,
    case y = "ypsilon"
    case z
    case q
}

print(axis.x.rawValue)
print(axis.y.rawValue)
print(axis.z.rawValue)
print(axis.q.rawValue)


// QUIZ QUESTIONs

// 1. What is the raw value for StrangeLetter.w?

enum StrangeLetter: Int {
    case z = 4, y, x = 0, w, v = 2, u
}

print(StrangeLetter.w.rawValue)

// 2. What is printed by the following code?

enum BigCat: Int {
    case cheetah
    case jaguar
    case lion // 2
    case tiger
}

var tag = 2

if let cat = BigCat(rawValue: tag) {
    switch cat {
    case .lion:
        print("lion") // rawValue is assigned value 2 that stands for case lion so "lion" is printed out
    case .tiger:
        print("tiger")
    case .cheetah:
        print("cheetah")
    case .jaguar:
        print("jaguar")
    }
}


/*
// MARK: supportive sources:
 
 Swift Enum - Basics, Raw Values, Associated Values, CaseIterable & More
    https://www.youtube.com/watch?v=CdBL7m1AeII
 */


//: [Next](@next)
