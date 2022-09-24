//: [Previous](@previous)

import Foundation

// MARK: 1. Closures Reloaded
    // taking rer pill : D

// MARK: 2. What Makes Closures So Special
// 00:00 The most important properties of closures that we have missed so are that they are:
        // 1st class citizens of the language, and
        // they capture their lexical environment

// sounds like greek? no worries, these are just fancy names for very simple concepts. Let's take a look at this 1st class thing:

// MARK: 3. Flying First Class
// 00:00 So what does it mean to be 1st class type? It means that you can use closures just like any other type, such as Ints, Floats, Strings..., and you may assign them to:

    // a) variables and constants
    // b) add to array and dictionaries, or actually to any collection
    // c) can return them from functions and closures
    // d) can receive them as parameters of another function or closure

// the last d) seems complex, let's start with easy ones

// MARK: 4. First Class Demo
// https://github.com/udacity/ios-nd-gcd/blob/swift-3/ClosurePlaygrounds/1-firstClass.playground/Contents.swift
/*:
# What does it mean for a Closure to be a first class citizen of the language?
*/

/*:
It means you can use them just like any other type, such as Ints, Floats, String, etc.
You can
* assign them to variables or constants,
* put then inside arrays or dictionaries,
* return them as the result of a function or closure
* and even receive them as parameters of another function or closure!

That last part seems a bit weird, so let's start with the most obvious parts.
*/

import UIKit

//: First we are going to assign a closure to a var or constant
//  1:00 when Int returns another Int
let f = { (x:Int) -> Int in
    // it adds x to 42
    return x + 42
}

/*:
1:19 Closures have types too! Look at the *results sidebar* on the right side, and you'll
see that the type of the closure above is ```Int -> Int```: it takes an ```Int``` and returns an ```Int```.

*/
// let f: (Int) -> Int declaration when option click on f
f(0)
f(1)
f(99)

/*:
You can call the closure you saved in the constant *f* in the normal way.
*/

f(89)

/*:
However, try to call it passing a String as a parameter: ```f("foo")```.
What happens? Why?
*/

// f("fooFighters") // Cannot convert value of type 'String' to expected argument type 'Int'

/*:
Now let's try something fancier! Let's put a bunch of closures inside an array
*/

let closure = [f]

// 2:13 here we have an array called closure, with just one closure inside and type is as you would expect, an array of Int to Int. So this [(Int)->Int] defines what kind of closure we can put inside this array. As long as the closure takes one Int and returns an Int, it should be able to put it in there. Let's add a few more:

// 2:37 so here we have the final array with several closures in there. All these closures have one thing in common. They have the same type, they take and Int and return Int. How does the compiler know that? Because of the first one. So this sets the type of closure that can go in there.
// 2:56 the socond closure in array has the full closure syntax with type information for the parameter and the return type. That's not really necessary, because compiler has that information already.
// 3:11 so the next one avoids the type information, and it works fine.
// the next one, does not have a return type, why? Because when a closure just has one statement, one line, the return is implicit, so the compiler knows the compiler should return x * x
// 3:36 and last but not least, we have this ultra simple version, where we do not even provide a name for the parameter, because in Swift, closures and functions can access their parameters or arguments by the position. So $0 means position zero ~ first parameter times 42 and return that
let closures = [
    f,                                  // our previous closure
    {(x:Int) -> Int in return x * 9},   // a new Int -> Int closure
    {x in return x - 1},                // no need for the type of the closure!
    {(x:Int) in x * 11},                 // no need for return if only one line
    {$0 * 3}                           // access parameter by position instead of name
]

/*:
4:05 Can we still call those closures stored in the dictionary?
*YES!*
*/

// 4:15 so right here we are iterating through the array of closures and for each closure we call it passing value 3. And in result block on right you can see the results.
for closureX in closures {
    closureX(3)
}

/*:
EXERCISE: Create an array with two closures, one that takes 2 integers and returns the sum as
another integer, and one that takes two floats and returns the sum as a float.
Will it compile? Why?
*/

let arrayOfTwoClosures = [ // Heterogeneous collection literal could only be inferred to '[Any]'; add explicit type annotation if this is intentional
    {(a: Int, b: Int) -> Int in return a + b},
    // {(f: Float, l: Float) -> Float in f + l}
    {$0 - $1} // MARK: for error comment this and uncomment line above
] // as [Any]

for closureA in arrayOfTwoClosures {
    closureA(2, 3)
}

/*:
## Closures as result values and parameters!

This last part is not really necessary, but if you're interested, we'll explain it in the next Playground.

*/

// MARK: 5. The Answer to Life...
// MARK: Exercise1
// video: so will this code run? Do not cheat by pasting it into Playground. Think aboout it.

let deepThought = { (question:String) in return "The answer to \"\(question)\" is \(7 * 6)!" }

let deepAnswer = deepThought("how old are you")
print(deepAnswer)

// Answer: YES it will run. Does not have a return type, why? Because when a closure just has one statement, one line, the return is implicit, so the compiler knows the compiler should return.

// MARK: Exercise1
// video: so will this code compile? Why? NO, it will not complie because of different types of closures within one array.

let sum = {(a: Int, b: Int) -> Int in return a + b}
let sim = {(a: Float, b: Float) -> Float in return a - b}

// MARK: uncomment as [Any] to see the error
let closuresSumSim = [sum, sim] as [Any] // Heterogeneous collection literal could only be inferred to '[Any]'; add explicit type annotation if this is intentional. To fix it insert as [Any]

//: [Next](@next)
