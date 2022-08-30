//: [Previous](@previous)

import Foundation
import UIKit

// Using a switch statement to extract associated values can be cumbersome, especially if an enum has many cases. To extract an associated value for a single case, an if case statement can be used.

enum ImageFilter {
    case sepia
    case verticalGradient(from: UIColor, to: UIColor)
    case horizontalGradient(from: UIColor, to: UIColor)
    case sketch(penThickness: Double?)
}

let filter1 = ImageFilter.horizontalGradient(from: .cyan, to: .yellow)
let filter2 = ImageFilter.horizontalGradient(from: .white, to: .orange)
let filter3 = ImageFilter.sketch(penThickness: 7.2)

//: `if case` works alongside the equals operator (=) to check and extract an associated value from an enum. While the syntax may look strange, the equals operator still behaves in an intuitive way; that is, the associated value on the left-hand side (containing `color1` and `color2`) is set equal to the associated value for the enum on the right-hand side (`filter1`).

if case ImageFilter.horizontalGradient(let color1, var color2) = filter1 {
    color2 = .yellow
    print("horizontal gradient with \(color1) and \(color2)")
}

//: To extract all values as constants use `if case let`.

if case let ImageFilter.horizontalGradient(color1, color2) = filter2 {
    print("horizontal gradiet with constants \(color1) and \(color2)")
}

// partially ignore an associated value

if case let ImageFilter.horizontalGradient( _, color2) = filter2 {
    print("the secont color of horizontal gradient of filter 2 is \(color2)")
}

// conditionally extract an associated value
// complex conditionals can be formed using `if case` and conditional statements separated by commas. If the conditional statements are held true, then the values are extracted and usable from within the `if case` block.

if case let ImageFilter.horizontalGradient(color1, color2) = filter1, color2 == .yellow {
    print("yes the secont color of gradient/filter1 is \(color2), while first one is \(color1)")
} else {
    print("no the second color of gradient/filter1 is not as defined in above contition !!!")
}

// A single associated value can also be extracted as a computed property. By using a computed property, you may avoid duplicate `if case` statements.

// note because case sketch(penThickness: Double?) is optional, below part "let thickness = penThickness" has to be there. Otherwise in case of no optional this part will have to be omitted/deleted.

extension ImageFilter {
    var hasHeavyPenThickness: Bool {
        if case let ImageFilter.sketch(penThickness) = self, let thickness = penThickness, thickness > 5.0 {
            return true
        } else {
            return false
        }
    }
}

filter1.hasHeavyPenThickness
filter2.hasHeavyPenThickness
filter3.hasHeavyPenThickness

// To learn more about extraction techniques, read [Pattern Matching, Part 4: if case, guard case, for case](http://alisoftware.github.io/swift/pattern-matching/2016/05/16/pattern-matching-4/) on Crunchy Development.

// QUIZ Extract associated values

enum VideoAdjustment {
    case volume(Int) // value is 0-100
    case time(Int) // time in seconds
    case useCaptions(Bool) // on/off
}

let adjustedVolume = VideoAdjustment.time(843)
// let captionsUsed = VideoAdjustment.useCaptions(true)

switch adjustedVolume { // switch captionsUsed
case let .volume(value):
    print("volume: \(value)")
case let .time(seconds):
    let hour = seconds / 3600 /* 3600 seconds in an hour */
    let min = (seconds % 3600) / 60 /* 60 seconds in a minute */
    let sec = seconds % 60

    // String(format:_:) creates a String with a specified format ("hh:mm:ss")
    // here, each value uses two digits and is prefixed with zeroes
    let timecode = String(format: "%02d:%02d:%02d", hour, min, sec)
    print("move to: \(timecode)")
case let .useCaptions(on):
    print("captions: \(on ? "on" : "off")")
}

// When the above code is executed, what is printed? Feel free to use a calculator or test the code in a playground.
// correct answer is move to: 00:14:03

enum AudioAdjustment {
    case volume(Int) // value is 0-100
    case time(Int) // time in seconds
    case useCaptions(Bool) // on/off
}

let change = AudioAdjustment.time(3601)

switch change {
case let .time(seconds) where seconds <= 3600:
    print("under an hour")
case .volume:
    print("change volume")
case .useCaptions:
    print("use captions")
case .time: // this case was added to avoid error
    print("case where seconds are greater than 3600")
}

// Will Xcode generate a compile-time error or warning for the above code?
// This switch statement is not exhaustive. What about VideoAdjustment.time adjustments where the seconds are greater than 3600? How will those be handled?

enum AutoAdjustment {
    case volume(Int) // value is 0-100
    case time(Int) // time in seconds
    case useCaptions(Bool) // on/off
}

let changeVolume = AutoAdjustment.volume(28)

if case AutoAdjustment.volume = changeVolume {
    print("change the volume")
} else {
    print("volume remains the same")
}

// When the above code is executed, what is printed?
// It prints "change the volume"
// Way to go! The if case letstatement confirms that changeVolume is a VideoAdjustment.volume case even though it ignores the associated value.

//: [Next](@next)
