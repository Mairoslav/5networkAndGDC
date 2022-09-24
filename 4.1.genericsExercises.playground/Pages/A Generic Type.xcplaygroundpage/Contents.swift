//: [Previous](@previous)
//: ### A Generic Type
//: - MARK: Callout(Exercise1):
//: Define a generic type (a class) called `IntAnalyzer` that specifies a single generic type parameter that must implement the `BinaryInteger` protocol. The generic type parameter should be used to define a property called `value`. You must also define an  initializer which sets the `value` property.

// generic type (a class) called `IntAnalyzer`
// that specifies a single generic type parameter that must implement the `BinaryInteger` protocol.
class IntAnalyzer<parameterConformist: BinaryInteger> {
    // generic type parameter should be used to define a property called `value`
    let value: parameterConformist
    // ou must also define an  initializer which sets the `value` property.
    init(value: parameterConformist) {
        self.value = value
    }
}

//: - MARK: Callout(Exercise2):
//: Extend `IntAnalyzer` so that it includes a function called `analyze` which prints the value property, its bit width (`value.bitWidth`), and its sign (`value.signum()`).

extension IntAnalyzer {
    func analyze() {
        print("bit width of value \(value) is \(value.bitWidth) and it sign \(value.signum())")
    }
}

//: - MARK: Callout(Exercise3):
//: Create an instance of `IntAnalyzer`, then call the `analyze` function.

let analyst = IntAnalyzer(value: 777)
analyst.analyze()

//: [Next](@next)
