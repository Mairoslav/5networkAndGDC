//: [Previous](@previous)

// import Foundation
import UIKit

enum ImageFilter {
    case sepia
    case verticalGradient(from: UIColor, to: UIColor)
    case horizontalGradient(from: UIColor, to: UIColor)
    case sketch(penThickness: Double?)
}

//: Unfortunatelly you cannot simply access an associaated value by its name like this
let filter1 = ImageFilter.horizontalGradient(from: .gray, to: .black) // color1, color2
let filter2 = ImageFilter.horizontalGradient(from: .white, to: .black)
let filter3 = ImageFilter.sketch(penThickness: nil)
let filter4 = ImageFilter.sketch(penThickness: 0.7)
// print(filter1.from) // value of type 'ImageFilter' has no member 'from'

//: So to use an associated value, it must be extracted. See the following examples for different extraction techniques.

//: Most often, associated values are extracted in a switch block. For cases that have an associated value, the `let` (I can opt for var also) keyword followed by a name will extract each  value from an associated value.

switch filter1 { // MARK: play with switching filters from 1 to 4, creating new ones...
case .sepia:
   print("sepia")
// case .verticalGradient(from: let color1, to: let color2): // MARK: can skip from: to: like this:
// case .verticalGradient(let color1, let color2): // MARK: can even place let in from when both are let:

case let .verticalGradient(color1, color2):
    print("vertical gradient from \(color1) to \(color2)")
// MARK: if you wannt to ignore the associated value, just leave the tuple off:
// case .horizontalGradient: // (from: let color1, to: let color2):
    // print("horizontal gradient") // from \(color1) to \(color2)")

// MARK: of if you want to partially ignore the associated value, use _ underscore to for any of the tuple elements you want to ignore
case let .horizontalGradient(color1, _):
    print("horizontal gradient with \(color1)")
// MARK: if you want to treat two cases with the same associated value types the same way, names for tuple elements must match as below, if color 3 used it would result in mismatch:
/*
case let .verticalGradient(color1, color2),
     let .horizontalGradient(color1, color2):
        print("gradient from \(color1) to \(color2)")
*/
case .sketch(penThickness: let thickness):
    // print("sketch using \(thickness ?? 0.0) thickness") // MARK: or alternative way to treat optional:
    if let thickness = thickness {
        print("sketch using \(thickness) thickness")
    } else {
        print("sketch using default 0.0 thickness, i.e. no/nil thickness")
    }
/*
default:
    print("when there is default, one or more cases can be skipped, now comment out default and will see that have to uncomment those cases that were commented out) */
}

//: Associated values can also be extracted as variables using the `var` keyword. Values extracted as variables are only available in the case where they are declared.

switch filter1 {
case .horizontalGradient(from: var color1, to: let color2):
    color1 = .yellow
    print("horizontal gradient with variable \(color1) and fixed \(color2)")
default:
    break
}

// MARK: advanced technique, instead of just extracting the associated value you can also perform conditional checks
//: Associated values may also be extracted based on conditions specified using the `where` keyword. If all conditions are held, then the values are extracted and the case statement is executed.

switch filter1 {
case .horizontalGradient(from: let color1, to: _) where color1 == .white:
    print("in horizontal gradient color one is white, yes \(color1)")
case .horizontalGradient(from: _, to: let color2) where color2 == .black:
    print("in horizontal gradient color thwo is black, yes \(color2)")
default:
    break
}

// blank switch statement that only has a default case
switch filter1 {
/*
case let .horizontalGradient(color1, color2):
    print("let be colors as original so \(color1) and \(color2)")
*/
default:
    // break // prints nothing, only breaks
    print("blank switch statement that only has a default case")
}

//: Associated values can be extracted using computed properties. By using a computed property, you may avoid duplicate switch statements.
//: So you can extract associated values, in the enum itself using a computed property.

extension ImageFilter {
    var colors: (from: UIColor, to: UIColor)? {
        switch self {// switch refers to the case for the image filter
        case let .verticalGradient(color1, color2),
             let .horizontalGradient(color1, color2):
             return (color1, color2)
        /*
        case .verticalGradient(let from, let to),
             .horizontalGradient(let from, let to):
            return (from, to)
        */
        default:
            return nil
        }
    }
    var penThickness: Double? {
        switch self {
        case .sketch(let penThickness):
            return penThickness
        default:
            return nil
        }
    }
}

// MARK: now for any image filter instance like filter1, filter2... the colors properties are available and we can use it to quickly access the color1 and color2 (respectivelly commented out alternative from and to colors) and penThickness

filter1.colors?.from
filter1.penThickness
filter3.colors

filter3.penThickness
filter4.penThickness
//: [Next](@next)
