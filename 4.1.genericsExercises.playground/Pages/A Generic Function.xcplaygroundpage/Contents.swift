//: [Previous](@previous)
//: ### A Generic Function
//: The following exercises will use the `printIfUIResponder` function.
//:
func printIfUIResponder<Type: UIResponder>(_ argument: Type) {
    print(type(of: argument))
}

//: - Callout(Exercise):
//: Which of the following invocations will cause a compiler error? Make an educated guess before removing the comment annotations!
//:
import UIKit


printIfUIResponder(UIView()) // OK, prints UIView
// printIfUIResponder(UIFont()) // cause error, cause not under protocol UIResponder. Correct > Error: Global function 'printIfUIResponder' requires that 'UIFont' inherit from 'UIResponder'
printIfUIResponder(UILabel()) // OK, prints UILabel


//: [Next](@next)
