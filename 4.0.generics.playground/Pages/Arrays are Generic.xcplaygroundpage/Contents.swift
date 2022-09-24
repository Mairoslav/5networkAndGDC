//: [Previous](@previous)
//: ### Arrays are Generic
//: Upon first glance, many do not realize that Swift arrays use generics. Specifically, the type that a Swift array stores is generic — it can be anything. When declaring an array using its more longhand syntax, this becomes apparent.
//:
// var intArray = Array<Int>()
var intArray = [Int]() // here two alternative ways of declaring empty Array
intArray.append(4)
intArray.append(2)
print(intArray)
//: The type specified in the brackets (ex. "<String>") is called a "concrete type". When specified, the concrete type takes the place of a generic type.
//:
var stringArray: Array<String> = ["one", "two", "three"]
print(stringArray)
//: Because Swift arrays use generics, they behave the same, regardless of the concrete type.
//: 0:35 I can print a count for each array
print(intArray.count)
print(stringArray.count)

//: I can add a value to each array
intArray.append(6)
stringArray.append("six")

//: and can remove all elements from each array
intArray.removeAll()
stringArray.removeAll()

/*
The fact that these arrays operate in the same way despite the use of different types is because of generics.
 
Without generics, I might have to separate code for each of them (intArray and stringArray) to do properties like the "count" or to write function like "append" or "remove all". But with generics you do not have to do any of that. We can share a lot of the same functionality despite using different types.
 
Before going further, it is important to show what is known as "longhand syntax for declaring an array", and it further reveals the generic nature of arrays. So when declaring an array:
*/

var boolArray: Array<Bool> // you can explicitly specify the type as "array" followed by brackets containing another type.
// var boolArray = Array<Bool>() //
boolArray = [true, true, false, true, false, false, true]
print(boolArray)

/*
 The type withing the brackets is what is known as a "generic type parameter". Normaly the compiler infers this type based on the values that you provide (...does not seem like that, checking it...because Array<Bool> not work), but if you want to be explicit. Than you have the option of using this "longhand syntax for declaring an array" too.
 */

var boolArray1: Array<Bool> = [true, false]

// 1:41 you can also initialize an array directly using the longhand syntax

var boolArray2 = Array<Bool>()

// so after the longhand syntax, you can specify an array initilizer, like the "empty initializer", which creates an empty array, or you can have an initializer that takes a single element. For example, you can provide array literal true

var boolArray3 = Array<Bool>(arrayLiteral: true) // and that will create an array with one value in it to begin with, which is Bool - true.

// as we know alternative to this longHandSynax is simpleSyntax, see below:

var boolArray4 = [Bool]()
var boolArray5: [Bool] = [true]

//: [Next](@next)
