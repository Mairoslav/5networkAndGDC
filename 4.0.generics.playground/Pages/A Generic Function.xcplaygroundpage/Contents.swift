//: [Previous](@previous)
//: ### A Generic Function
//: Generics can be applied to functions and types (like we saw in previous lesson). To write a generic function, specify a generic type after the function name using the bracket notation (ex. `func myFunction<Type>`). Then, for any arguments that should be generic, use the generic type instead of a concrete type. Below, the generic type is called `T`; `T` can represent any type. That's why generics.

// 0:17 I will start by creating a function that is not generic, it is called printType, and this function takes a single argument, which is an Int. Then the body of the function will print out the type of the argument, which is in this case going to be Int.

func printType(_ argument: Int) {
    print(type(of: argument))
}

// 0:26 Now this is not particularly useful function, because we are only operating on sigle type, where I am always going to get the same print statement. But when we use generics, this becomes much more powerful. We'll go and call it just to see what happens, and it print out a type of 4, which is an Int.

printType(4)

// 0:41 Now what if we wanted to print the type of any arument, not just this Int argument. We could start writing functions like printTypeString, printTypeBool... basically following the above syntax, just replacing Int with String, Bool... But that would be really too much repetitive.

// 0:53 Instead we make the parameter for printType generic, meaning that the argument could be of any type.

// argument is of type `T`, it can be anything
func printType<T>(_ argument: T) { // we declare generic type T in <> brackets after the function, and also insert it at place where specific type was, check Int in previous example ~ instead of Int now T.
    print(type(of: argument))
}

// 1:40 now we can call this function using any type, see below:

printType(4) // Int
printType("udacity") // String
printType(4.5) // Double
printType(false) // Bool

//: For readability, give a generic type a more descriptive name. 1:50 ~ we can be more descriptive. The key is that you want the name to be uppercased to distinguish it from values.

func printTypeWithNamedGenericType<Type>(_ argument: Type) { // instead of T > Type
    print(type(of: argument)) // this part is the same
}

printTypeWithNamedGenericType(4) // Int
printTypeWithNamedGenericType("udacity") // String
printTypeWithNamedGenericType(4.5) // Double
printTypeWithNamedGenericType(false) // Bool

//: Without generics, a developer would have to duplicate code to handle differing types — even if the types are being used the same way!

func printIntType(_ int: Int) {
    print(type(of: int))
}

func printStringType(_ string: String) {
    print(type(of: string))
}

printIntType(4) // Int
printStringType("udacity") // String

// 2:27 But as this is written, it is actually quite limiting because our generic parameter is type, that could be anything. The swift compiler will not allow us to use the parameter except in ways that could only be applied to any type. For example if I want to add this argument to another integer, it does not work:

func printTypePlus4<Type>(_ argument: Type) {
    print(type(of: argument))
    
    // let x = 4 + argument // Cannot convert value of type 'Type' to expected argument type 'Int'
}

// And that is because the compiler does not know how to combine an Int with this generic type Type. And that's why more often than not we want to resctict the range of possible types that can be used as generic parameter. So let's modify this function just a bit.

//: ~ A generic type can be bound or constrained such that it can only represent concrete types which adhere to some protocol or inherit from a certain class. In the example below, the generic type is constrained such that it can only represent types which implement the `UnsignedInteger` protocol — essentially, non-negative integers.

// 03:01 I now have changed the func so that it no longer accepts any type, and instead will only accept types that implement UnsignedInteger protocol - protocol that represents positive Integers.
func printUIntTypes<Type: UnsignedInteger>(_ argument: Type) { // constrained by UnsignedInteger
    print(type(of: argument)) // prints type of value used as argument for parameter
    
    // 03:28 In fact we can now add this parameter to another Integer and the compiler knows exactly what to do.
    let x = 4 + argument
    print(x) // prints 4 + value used as argument for parameter
}

// 03:34 so by adding this type of conformance to our generic type, we're applying what is known as a "generic constraint". And using this new generic function, it is pretty straightforward and should accept any UnsignedInteger

let unsignedInt: UInt = 4 // so we can call it with a UInt, which is unsigned integer that represented by the same number of bits as your macchine processor, so that's 32 or 64 bit macchines.
let un_signedInt8: UInt8 = 40 // Then we have UInt8, which is undersigned integer represented by 8 bits, meaning that it can range from 0 - 255.
let un_signedInt16: UInt16 = 400 // And finally UInt16, which is undersigned integer represented by 16 bits, meaning it can range from 0 - 65535.

// https://useyourloaf.com/blog/swift-integer-quick-guide/
// 04:20 that was bit about UIInt, UIInt8, UIInt16 types also, still what is important here is that each of these types conform to that UndersignedInteger protocol - protocol that represents positive Integers. Therefore, our generic function will accept them as generic parameters.

print("...")
printUIntTypes(unsignedInt) // UInt
printUIntTypes(un_signedInt8) // UInt8
printUIntTypes(un_signedInt16) // UInt16

//: - Callout(Watch Out!):
//: When a generic type is "constrained", any concrete types that do not adhere to the constraint will cause Xcode to complain.
//:
// uncomment the lines below to see Xcode complain that 4 (Int), -4 (Int), and "abc" (String) do not implement the `UnsignedInteger` protocol, and cannot be used in place of the generic type
// printUIntTypes(4) /* `Int` is not unsigned because it can store negative values ~  04:34 even a plain old Int will not work, but that makes sense, because Int can be used to represent negative numbers too, so those are signed numbers, and the UndersignedInteger protocol is positive integers only. */
//printUIntTypes(-4)
//printUIntTypes("abc")

// MARK: text under the video:

/*
 An interesting fact about generic functions
 Most often, you'll see generics are used for the values passed into functions. However, you can also use generics to pass a specific type into a function.

 Let's say we wanted to create a function that converts a UInt8 into another UnsignedInteger type.
 */

func convertUInt8<T: UnsignedInteger>(_ argument: UInt8, toType: T.Type) -> T {
    return T(clamping: argument) // In computer graphics, "clamping" is the process of limiting a position to an area. Unlike wrapping*, clamping merely moves the point to the nearest available value. Here from UInt8 to UInt16 i.e. from range of 0 - 255 to range of 0 - 65535
    
        // What Does Wrapper Mean? In the context of software engineering, a wrapper is defined as an entity that encapsulates and hides the underlying complexity of another entity by means of well-defined interfaces
}

/*
 Don't worry about the specific details of this function, just focus on the values passed in.

 There's a generic parameter, T, which must be an UnsignedInteger. Unlike before, the argument is just a UInt8, but it's being converted into whatever type T is.

 We're not passing in a value for T, but we need to let the function know which type to convert into with the parameter ... toType: T.Type ...
 
 Every type name in Swift has a Type property, so we can pass in the specific type. We'd call the function like this.
 */

let unsignedInt8: UInt8 = 255
var unsignedIntFrom8to16 = convertUInt8(unsignedInt8, toType: UInt16.self)
unsignedIntFrom8to16 = 65535
print(unsignedIntFrom8to16)
print(type(of: unsignedIntFrom8to16))

/*
 The type is passed in with .self meaning we're referring to the type itself. In this case, we pass in UInt16.self.

 So we can use generics for both the values themselves and passing in specific types - as we have seen thanks to "generic constraint" via using <Type: UnsignedInteger>. The usefulness of this might not be apparent right away, but you'll see generics used in this way when working with an important data format called JSON*.
 
 *"JSON stands for JavaScript Object Notation. JSON is a lightweight format for storing and transporting data. The JSON format consists of keys and values. In Swift, think of this format as a dictionary where each key must be unique and the values can be strings, numbers, bools, or null (nothing)". Source: https://medium.com/swlh/how-to-work-with-json-in-swift-83cd93a837e
 */

// MARK: QUIZ - question 1

// For the first question, consider the following code snippet.
// Will Xcode generate a compile-time error or warning for the code above? ... ***Note, by default, enums that provide raw values implement the RawRepresentable protocol...
        // a) Xcode will generage an error or warning
        // b) Xcode will not generate an error or warning - YES this is true, Got it! Position doesn't specify a raw type — this means it is not RawRepresentable and cannot be used by the printRawRepresentation(_:) function.


enum Position: String { // Position did not specify a raw type, this corrected by specifying type, i.e. by adding ": String after enum Position
    
    case first = "Aliosha", second = "Bao", third = "Celine", fourth = "Dion"
}

func printRawRepresentation1<T: RawRepresentable>(argument: T) { // RawRepresentable
    print(argument.rawValue) // prints Dion
    // print(argument) // prints fourth
}

printRawRepresentation1(argument: Position.fourth)

// a) Xcode will generage an error or warning. Got it! Position doesn't specify a raw type — this means it is not RawRepresentable and cannot be used by the printRawRepresentation(_:) function. THIS CORRECTED ABOVE - corrected by specifying type, i.e. by adding ": String after enum Position.

/*
 // MARK: QUIZ - question 2

 // For the second question, consider the following code snippet.
 // Will Xcode generate a compile-time error or warning for the code above?
        // a) Xcode will generage an error or warning
        // b) Xcode will not generate an error or warning.
 */

enum Direction: String {
    case north = "North Carolina", south = "Florida", east = "NY", west = "California"
}

func printRawRepresentation2<T: RawRepresentable>(argument: T) { // RawRepresentable
    print(argument.rawValue) // prints rawValue, in this case North Carolina
    // print(argument) // prints argument, in this case north
}

printRawRepresentation2(argument: Direction.north)

// b) Xcode will not generate an error or warning. That's right. Because Direction specifies a raw type, it implements RawRepresentable and can be used by the printRawRepresentation(_:) function.

//: [Next](@next)
