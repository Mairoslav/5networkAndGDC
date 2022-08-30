//: [Previous](@previous)
//: ### Associated Values
//: - Callout(Exercise):
//: Create an array of `LunchFruit`. The array should contain seedless grapes, 4 clementines, and a whole (not sliced) apple.
//:
enum LunchFruit {
    case grapes(seedless: Bool)
    case clementines(count: Int)
    case apple(sliced: Bool)
}

let fruitBasket: [LunchFruit] = [.grapes(seedless: true), .clementines(count: 4), .apple(sliced: false)]
print(fruitBasket[0])
//: - Callout(Exercise):
//: Define an enum called `Prize` with cases representing a coffee mug, business cards, or lanyard. For business cards, the prize includes associated values for a name (`String`) and image (`UIImage`). For the lanyard, the prize includes an associated value for color (`UIColor`).
//:
import UIKit

enum Prize {
    case coffeMug
    case businessCards(name: String, image: UIImage)
    case lanyard(color: UIColor)
}
//: [Next](@next)
