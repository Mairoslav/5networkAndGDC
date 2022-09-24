//: [Previous](@previous)
//: ### MARK: A Generic Type
//: Generics can be applied to an object's properties to create what is known as a generic type. Similar to generic functions, a generic type is created by specifying the object's name followed by a generic type using the bracket notation (ex. `struct MyType<Type>`). Then, for any properties that should be generic, use the generic type instead of a concrete type.
//:
import UIKit

struct TypeAnalyzer<T> { // struct typeName<genericTypeParameter>
    let value: T
    
    // represents the sub-structure of the generic type
    // https://www.swiftbysundell.com/articles/reflection-in-swift/
    var mirror: Mirror {
        return Mirror(reflecting: value)
    }
    
    // print information about the type
    func analyze() {
        print("Type: \(type(of: value))") // Type:Int because 2 is Int
        print("Value: \(value)")// Value 2
        // 0:45 then it checks and prints if it has any superclass
        if let superClassMirror = mirror.superclassMirror {
            print("Superclass: \(superClassMirror.subjectType)")
        }
    }
}

// 01:05 to create an instance of a TypeAnalyzer, we can use the shorthand initialization. With the shorthand initialization, the generic type is inferred based on the value that we pass in during the initialization. As we can see in the output and the debug console at the bottom, the compiler has inferred a Value: 2, of course to be of Type: Int.

let x = TypeAnalyzer(value: 2)
x.analyze()

/*
 0:47 because the generic type T we are using here is not restricted, the compiler then restricts us quite a bit. For instance, we can only use the generic property that we have, this value in ways that are acceptable of any type, like calling the type of function, or checking if it has a superclass.
 */

// 01:25 Or you can use the longhand initializer, where you explicitly specify the type that you want to be applied to the generic type for TypeAnalyzer (Type: UIView).

let view = TypeAnalyzer<UIView>(value: UIView(frame: CGRect.zero))
view.analyze()

// 01:34 let's move to the more realistic example.

//: Like generic functions, the generic type can be named and constained. In the example below, `ZooExhibit` is defined where its animals property is generic and constrained to any type that implements the `Animal` protocol.

protocol Animal { // animal is a type that has:
    var name: String { get } // a name variable
    static var commonName: String { get } // static comonName and emoji
    static var emoji: String { get }
}

// 1:46 then I create two types/structs that implement Animal

struct Whale: Animal {
    let name: String
    static let commonName = "Whale"
    static let emoji = "🐳"
}

struct Dolphin: Animal {
    let name: String
    static let commonName = "Dolphin"
    static let emoji = "🐬"
}

// 1:58 now I am going to create another generic type. It is going to be struct ZooExhibit, and I want the ZooExhibit to work in similar way to Swift array, that is I want it to be able to store an array of values, but unlike an array, I want those values to only be Animals.
// 2:14 so I have added this generic type called <AnimalType: ... >
// and I have constrained it such that only types that implement Animal can be used
struct ZooExhibit<AnimalType: Animal> {
    // 2:21 then using the generic type, I have created property called animals
    let animals: [AnimalType]

    // 2:26 last let me add this simple function that browses through the array of animals and says hello
    func tourTheExhibit() {
        print("Welcome to the \(AnimalType.commonName) Exhibit \(AnimalType.emoji)!")
        for animal in animals {
            print("Say hello to \(animal.name) \(AnimalType.emoji).")
        }
    }
}

// 2:31 to create an instanc of ZooExhibit, I'll use both shorthand and longhand syntax, and for each of these I provided a value for the animals array.
// the shorthand and
let exhibit1 = ZooExhibit(animals: [Whale(name: "Wendy"), Whale(name: "Wu")])
exhibit1.tourTheExhibit() // call function, and our generic type is working

// the longhand syntax - to specify the concrete type
let exhibit2 = ZooExhibit<Dolphin>(animals: [Dolphin(name: "Dilbert"), Dolphin(name: "Dezeri")])
exhibit2.tourTheExhibit()

//: - Callout(Watch Out!): 2:50
//: A single generic type can only be substituted with one concrete type. If Xcode is unable to determine the concrete type that should be substituted for a generic type, it will complain. Because in exhibit3 we mix two different animals i.e. two types.

// :which type should be used? whale or dolphin? Xcode isn't sure, so it complains
// MARK: uncomment to check it out
// let exhibit3 = ZooExhibit(animals: [Whale(name: "Wilber"), Dolphin(name: "Daphnie")]) // Error: Type of expression is ambiguous without more context
// in other words the reason for the error is that Swift arrays can only store one type at a time, and we are trying to store two different types (two animals).


//: Extensions can be combined with generics for truly powerful effects. With an extension, it is possible to specify functionality that should only apply to a generic type when the concrete type meets inherits from a specific protocol.
//: 3:15 as have seen in previous lessons, an extension can be used to add functionality to a type after it has been defined. But when combined with generics, we can add extensions that are only applied to a type when the generic parameter meets certain criteria.
protocol Feedable { // define new protocol called Feedable
    // this protocol requires a new static constant called favoriteFood
    static var favoriteFood: String { get }
}

// 3:45 then I'll have the Dolphin class implement protocol Feedable
extension Dolphin: Feedable {
    // and provide a favorite food, which is fish
    static let favoriteFood = "🐟"
}

// this is when thinks become interesting
// 3:54 using extensions and generics I can specify new functionality that I only want to apply when the generic parameter, that is the AnimalType, also implement Feedable
extension ZooExhibit where AnimalType: Feedable {
    // 4:05 when this is the case, I have defined this new function that feeds each of the animals in the exhibit.
    func feedTheAnimals() {
        for animal in animals {
            print("You feed \(animal.name) \(AnimalType.emoji) some \(AnimalType.favoriteFood).")
        }
    }
}

// 4:10 now I can reuse the existing Dolphin exhibit, so that's exhibit2 from earlier and suddenly we have this new function called feedTheAnimals().
exhibit2.feedTheAnimals()
// 4:18 awesom, but notice, if I tried to call feedTheAnimals() for exhibit1, the exhibit of Whales, the function does not exist. That's because the Whale type does not implement the Feedable protocol. And as our extension specifies, this functionality should only be added to animal types that implement the Feedable protocol.

// because `Whale` is not `Feedable`, the `feedTheAnimals()` function doesn't exist for the whale exhibit MARK: uncommentToCheck:
// exhibit1.feedTheAnimals() // Error: Referencing instance method 'feedTheAnimals()' on 'ZooExhibit' requires that 'Whale' conform to 'Feedable'
// to avoid error, and make above possible, would need to add below code above (when here at the bottom it does not execute, because too below versus related code). I.e. make Whale to conform to the protocol Feedable.

extension Whale: Feedable {
    static var favoriteFood: String = "🐟🐟🐟"
}

// MARK: 6. Quiz: A Generic Type
// MARK: quiestion1: For the first question, consider the following code snippet:
// What is printed by the code?
// a) You swam by Dori
// b) You flew by Dori - THIS ONE IS TRUE, Good job. exhibit is of type ZooExhibit<Dragon>. Because Dragon is a Flyable animal, the flyTheExhibit() function exists, and "You flew by Dory." is printed.
// c) Nothing is printed, the code will not compile.

protocol Animale { var name: String { get } }
protocol Flyable {}
protocol Swimable {}

struct Whaale: Animale, Swimable { let name: String }
struct Dragon: Animale, Flyable { let name: String }
struct ZooExhibitZ<AnimalType: Animale> { let animals: [AnimalType] } // had to rewrite Animal to Animale also here

extension ZooExhibitZ where AnimalType: Flyable {
    func flyTheExhibit() {
        for animal in animals {
            print("You flew by \(animal.name).")
        }
    }
}

extension ZooExhibitZ where AnimalType: Swimable {
    func swimTheExhibit() {
        for animal in animals {
            print("You swam by \(animal.name).")
        }
    }
}

let exhibit = ZooExhibitZ(animals: [Dragon(name: "Dory")])
exhibit.flyTheExhibit()

// MARK: quiestion2: For the first question, consider the following code snippet:
// What is printed by the code?
// a) You swam by Wilbur
// b) You flew by Wilbur
// c) Nothing is printed, the code will not compile. THIS IS CORRECT. That's it! exhibit is of type ZooExhibit<Whale>. Because Whale is not a Flyable animal, the flyTheExhibit() function does not exist and nothing is printed.

protocol Animals { var name: String { get } }
protocol FlyAble {}
protocol SwimAble {}

struct Whalee: Animals, Swimable { let name: String }
struct Dragonn: Animals, Flyable { let name: String }
struct ZooExhibitX<AnimalType: Animals> { let animals: [AnimalType] }

extension ZooExhibitX where AnimalType: Flyable {
    func flyTheExhibit() {
        for animal in animals {
            print("You flew by \(animal.name).")
        }
    }
}

extension ZooExhibitX where AnimalType: Swimable {
    func swimTheExhibit() {
        for animal in animals {
            print("You swam by \(animal.name).")
        }
    }
}

let exhibitt = ZooExhibitX(animals: [Whalee(name: "Wilbur")])
// MARK: uncomment to see the Error:
// exhibitt.flyTheExhibit() // Error: Referencing instance method 'flyTheExhibit()' on 'ZooExhibitX' requires that 'Whalee' conform to 'Flyable'
// simply whale would need to be Flyable for code to execute. 

//: [Next](@next)
