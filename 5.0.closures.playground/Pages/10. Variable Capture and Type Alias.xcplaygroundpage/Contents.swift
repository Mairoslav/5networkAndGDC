//: [Previous](@previous)

import Foundation

import UIKit
/*:
 https://github.com/udacity/ios-nd-gcd/blob/swift-3/ClosurePlaygrounds/3-capture.playground/Contents.swift
MARK: 9. Variable Capture Intro
# Variable Capture

There's one last thing about functions and closure (we know by now they're the same thing) that we need to know.

It's very easy to understand and even seems very natural, but not all languages have this feature. When you add it to the *first-type* nature of Swift's functions and closures, it tyrns them into super powerful tools!
*/

/*:
## typealias
MARK: 10. Variable Capture and Type Alias
MARK: ```capture of lexical environment```
0:11 Before we get started, let's take a look at a concept that will be very useful in our examples of variable capture (actually, the fancy name for this is ```capture of lexical environment```. Feel free to drop this in any casual converstaion if you really want to look like a nerd 😃!).

An **alias** is a simple way of calling something or someone that has a complex or funny name.

For example, say you are a huge, professional wrestler and you want your name to scare the crap out of your opponent.
Do you seriously think *Terry Jean Bollette* will do? Of course not! That's why he goes by his typealias *Hulk Hogan*.
*/

//: Did you just call me Terry Jean?!
let terry = UIImage(named: "terry.jpg")

/*:
0:40 Or you're just starting your career as a pop singer, but your parents bestowed upon you the aristocratic sounding name of *Florian Cloud de Bounevialle Armstrong*.

It certainly sounds impressive, but your fans will have a hard time remembering it.

Better go by the ```typealias``` Dido.
*/
let florian = UIImage(named: "dido.jpg")

/*:
In Swift you can also give new names to existing types, and this is extremely useful when the original name is complex.

Something like being able to call *Issur Danielovitch Demsky* *Kirk Douglas*. Much better, don't you think so?
*/

/*:
MARK: 11. Type Alias Example
00:00 Let's start with something simple. I don't like having to call a Integer an Int. Can we change that? Of course!

Just use the following template:
```typealias NewName = OldName```
*/
typealias Integer = Int

//: Now I can use ```Integer``` instead of ```Int``` whenever I feel like. It's all the same to the compiler!
let z: Integer = 42 // Integer has become alias for Int, and we can use it any time we want
let q: Int = 42
// 0:33 above two lines are exactly the same

/*:
// 0:47 This truly becomes useful when dealing with funky types, such as those of functions (and closures!)

For example, the type of a function that takes an Int and returns another one, would be
```(Int)->Int```

That can be confusing... and I do not like it. So let's call it a ```IntToInt```:
*/
typealias IntToInt = (Int) -> Int // so instead of (Int) -> Int, I can use IntToInt when defining type of closure... that makes life more easy

/*:
Now let's create a typealias for a function that takes no parameters (Void) and returns an Int.

I'll call that an ```IntMaker```:
*/
// typealias IntMaker = (Void) -> Int // When calling this function in Swift 4 or later, you must pass a '()' tuple; did you mean for the input type to be '()'?. Replace '(Void)' with '()'
typealias IntMaker = () -> Int
// 1:30 now we can use any of these types to  define function that takes an Integer and retur an Integer or one that takes nothing and returs Integer. This will become very, very useful in the next lesson where we finally tackle variable capture.

/*:
// MARK: 12. Variable Capture at Last
## Variable capture, at last!

Now we can finally move on to the main course: how functions (and closures) capture variables.

Take a close look at the function ```makeCounter()``` below.

The code is pretty short, but it will require some close inspection to understand the first time.

*/

// Explain capture with function syntax, as it simpler ...........................
// 0:18 what is special about it? Well it returns a function (or can also closure, remember that they care the same, can be substituted) - an IntMaker. And since functions and closures are class objects, we can return them from another function. So far that is normal. Just like some machines return other machines, some functions can create other functions. There is nothing special about that.

// 1:00 what else is interesting, or at least unusual? It has a function within itself. So it contains a function defined within function makeCounter. Well, that's normal too. Just like you can have a machine that contain other machines, and these are only visible from the within the contained machine (one inside) - think of your radio inside your car. So no big deal.

// 1:25 and it is actually useful and good practice to break down a long function, not this one but a long function, or a complex one into small simple functions by using interfunctions that do part of the total job.

// 1.43 what else is interesting about this? The really, really interesting and funky part by the way, is that inner function adder() can access this variable that is defined before it. Not only can it access it, but it is changing it. It is adding one to that, that's what we call variable capture.

// 2:10 so to understand this let's create two closure of type IntMaker by calling twice makeCounter and save them into two variables.................................
// MARK: above text from minute 00:18 is written also below in QUIZ section... from minure 2:21 follow the default text below

func makeCounter() -> IntMaker { // typealias IntMaker = () -> Int
    var n = 0 // first n has value 0
    
    // Functions within functions?
    // Yes we can!
    func adder() -> Integer { // typealias Integer = Int
        n = n + 1 // then adder adds 1 to n and assigns it to n
        return n // adder returns this n
    }
    return adder // ***** makeCounter returns adder
}

/*:
QUIZ:
What does it return?

### 0:18 It returns a function

Yes it does, and there's nothing really special about that. Just like some machines create other machines, some functions can create other functions.
*/
let t101 = UIImage(named: "T101.jpg")   // you start by making functions that make functions, then machines that make machines, and then...

/*:
### 1:00 It contains a function defined within itself!

Yeah, don't panic, that's normal too. Just like you can have machines that contain other machines, and these are only visible from within the containing machine: think of your radio inside your car. No big deal.

1:25 It's actually useful to break down a long function by using *inner* functions that do part of the total job.

### 1:43 adder can *access* the variable *n*!

That's the big deal.

* ```makeCounter``` defines a variable called ```n```, sets it to zero.
* Then, it defines a function called ```adder``` that updates the value of ```n``` and returns it.
* Last but not least, it returns the ```adder``` function.


The real magic is going on inside the ```adder```: **it can access all the variables defined before it!**
Not just n, put also z, which was defined way before - check line 53 typealias Integer = Int

It doesn't just *access* n, it actually *modifies* it! And here is where things could go very wrong...

Let's create 2 closures of type ```IntMaker``` by calling twice ```makeCounter``` and save them in two variables as below:
*/

let counter1 = makeCounter() // let counter1: IntMaker, when option click on counter1
let counter2 = makeCounter()


/*:
#### 2:21 Both ```counter1``` and ```counter2``` take no arguments and return an Int.

Think very carefully what the output should be: 1, 2, 3...
QUIZ
*/
counter1()
// 2:48 and what happens when I call again counter1()? What do you expect? Counter which is a type of adder, keeps adding one to n, and that value remains there, so we get 2, 3...
counter1()
counter1()


/*:
#### 3:11 And now, for the *grand finale*, what do you think this call will return?

QUIZ
Explain why you think it will return the value you expect.
// My answer: because above we were running function makeCounter() that was assigned to constant counter1, while below we are running the same function makeCounter() however assigned to different constant counter2. Because for this constant function has not been yet called, n starts from 0 i.e. counter counts 1, 2, 3...
// 3:23 you might have expected it to return 4, Actually that would not be very useful. Because that would mean that every function adder shares this n. The first languages that implemented this "variable capture feature" did behave that way, but was soon realized that it was a bug. It was not a feature.
// 3:43 so right now every single closure that we return from makeCounter takes its own copy of all the captured variables. So every time an ```adder``` is created ... continue via default text below.
*/
counter2()
counter2()
counter2()

/*:
### Safe capture

The bottom line is that every time an ```adder``` is created, it takes a copy of all captured variables. Therefore, each closure has its own copy of the environment (envitonment means: the values of all variables that were captured).

This is done for safety and also to keep you sane: the value of a variable will never change out of the blue, because, somewhere some closure decided to chnage it.  Everybody has it's own copy.
*/

/*:
## Wrapping up!

We've learned quite a few things about Swift in this lesson, so let's recap:

* Functions and closures are the same thing. We just have 2 different syntaxes to express one same thing.
 
* Functions and closures are first-class citizens of our language: we can treat them like any other type.
 
* Functions and closure capture variables defined before the closure or function is defined.

It might not seem obvious to you at this point, but those 2 last features make Swift a far more powerful language. They are the base of a different style of programming called *Functional Programming*.

Its popularity is increasing a lot lately. However, you won't need it to finish the Nanodegree program or even land your first job, so don't worry, it's something that you can learn later if you want.

If you are interested, you might want to read any of these books:

* [To Mock a Mockingbird](http://www.amazon.com/To-Mock-Mockingbird-Other-Puzzles/dp/0192801422) by Raymond Smullyan: a gentle introduction to Functional Programming using birds as an analogy. Check also https://www.orellfuessli.ch/shop/home/artikeldetails/A1001561254
* [Functional Programming in Swift](https://www.objc.io/books/fpinswift/) by Chris Eidhof and Florian Kugler. This book assumes you already know Swift and teaches you how to use in a functional way.

## On to Grand Central Dispatch

In the meantime, we'll move to the next chapter which deals with *Grand Central Dispatch* (GCD). This is a library that allows us to create background tasks wiht great ease. This is vital to ship great Apps and avoid being rejected from the App Store.

Our newly gained knowledge of closures will make understanding GCD a breeze, so let's move on and learn it! 😉
*/

/*
 MARK: 13. Type Alias
 00:00 this typealias:
 */

typealias binaryFunction = (Int, Int) -> Int

// a) defines a type for a function that takes two Ints and return Int, or
// b) defines class with three Ints

// YES a) is corrrect, that is the way to go.

/*
 MARK: 14. Capture
 00:00 would this coder run?
 */

var j = 5.0
/*
func g(x: Int) -> Double {
    return Double(x) / j
} */

func g(x: Double) -> Double { // above is original example, just here x defined directly as Double, above it is changed from Int to Double by Double(x). If not redefined, Swift does not allow Int and Double to be divided.
    return x / j
}

// a) no, because the function g cannot access variable z defined before it
// b) no, because g is function and only closures can capture variables
// c) yes, function g can access variable j by capturing it

// my answer a), WRONG
// c) is CORRECT

g(x: 100) // func g(x: Double) -> Double, when option click on g

// remember to do closures exercises

//: [Next](@next)
