//: [Previous](@previous)

import Foundation

/*:
 https://github.com/udacity/ios-nd-gcd/blob/swift-3/ClosurePlaygrounds/2-closuresAndFunctions.playground/Contents.swift
# Closures & Functions: same old, same old...
*/
import UIKit

/*:
## Functions and closures are the same thing

00:00 So far, it looks like a closure is a function with some extra features and a slightly different syntax.

*Not so, little grasshopper!*

Functions and Closures are exactly the same thing, they just have a different syntax! Therefore, all the 'extras' that Closures pack, are also available to functions.

**Closures and functions are just alter egos, like Peter Parker and Spiderman.**
*/
let alterego = UIImage(named: "peterSpiderman.jpg")

/*:
The function and closure below are exactly equivalent. They don't just do the same thing (check them out!), they *are* the same thing.
*/

// 0:50 first we have function that takes an Integer, returns an Integer and it adds 42 to it
func foo(x:Int) -> Int {
    return 42 + x
}

// and then we have a closure that do exactly the same thing
let bar = { (x: Int) -> Int in
    return 42 + x
}

// 01:00 they look equivalent, but actually they are more then just equivalent. They are exactly the same thing.

/*:
01:07 Actually, when the compiler finds a function declaration such as ```foo```, it will take the following steps:

* Create a closure that takes an Int and returns 42 plus that Int.
* Then, assigns this closure to a constant called ```foo```

Sounds familiar? Yep, that's exactly what you did for bar!
*/



//  01:30 so the Bottom Line:

// Since functions and closures are the same thing, use whatever syntax makes more sense at a given time.

// 01:44 so if closures and functions are exactly the same thing, we should be able to add functions to a collection (such as an Array) as we just did with closures in the previous playground!

// **Soitenly!**
// It **is** the same thing!

let soitenly = UIImage(named: "soitenly.jpg")

// 01:57 I am going to show you few function and then will add them to an array, and iterate through the array, and call the functions just as we did before.
// add a few functions to an array and then call them
func larry(x: Int) -> Int {
    return x * x
}

func curly(n: Int) -> Int {
    return n * (n - 1)
}

func moe(n: Int) -> Int {
    return n * (n - 1) * (n - 2)
}

// 2:17 it works, here we have three functions within the array
var stooges: [(Int) -> Int] = [larry, curly, moe]

for stooge in stooges {
    stooge(42)
}

/*:
2:25 Could we add the ```bar``` closure to ```stooges``` array?
YES!, they have the same type and it doesn't matter if they where defined using the closure syntax or the function one.
*/

stooges.append(bar)
for each in stooges {
    each(42)
}

/*:
Could we add the function ```baz``` below to ```stooges```?
Explain why.
No because function baz returns different type versus closure stooges. Double vs Int .
*/
func baz(x: Int) -> Double {
    return Double(x) / 42
}

// MARK: uncomment to see an error: 
// stooges.append(baz) // Cannot convert value of type '(Int) -> Double' to expected argument type '(Int) -> Int'. Would need to change Double to Int in baz function.

//: [Next](@next)
