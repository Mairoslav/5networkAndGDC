//: [Previous](@previous)
//: ### Subclass a Generic Type
//: The following exercises will use the `IntAnalyzer` struct. Notice the name of the property has changed from previous examples. It is now called `value1`.
//:
class IntAnalyzer<T: BinaryInteger> {
    let value1: T
    
    init(value1: T) {
        self.value1 = value1
    }
}

//: - MARK: Callout(Exercise1):
//: Subclass `IntAnalyzer` to create a new struct called `IntsAnalyzer`. `IntsAnalyzer` will include a new property called `value2` which should use the generic type inherited from `IntAnalyzer`.

// Subclass `IntAnalyzer` to create a new struct called `IntsAnalyzer`
class IntsAnalyzer<T: BinaryInteger>: IntAnalyzer<T> {
    // `IntsAnalyzer` will include a new property called `value2`
    let value2: T
    
    // which should use the generic type inherited from `IntAnalyzer`.
    init(value1: T, value2: T) {
        self.value2 = value2
        super.init(value1: value1)
    }
}

//: - MARK: Callout(Exercise2):
//: Extend `IntsAnalyzer` so that it includes a function called `analyzeInts` which prints if `value1` and `value2` are equal, if they share the same sign, and if they have the same number of trailing zero bits (e.g. `value1.trailingZeroBitCount`).

// Extend `IntsAnalyzer`
extension IntsAnalyzer {
    // so that it includes a function called `analyzeInts`
    func analyzeInts() {
        // which prints if `value1` and `value2` are equal, if they share the same sign, and if they have the same number of trailing zero bits (e.g. `value1.trailingZeroBitCount`).
        if value1 == value2 && value1.signum() == value2.signum() && value1.trailingZeroBitCount == value2.trailingZeroBitCount
        {
            print("""
                  values \(value1) and \(value2):
                  a) are equal
                  b) share the same sign, and
                  c) have the same number of trailing zero bits
                  """)
        } else {
            print("""
                  values \(value1) and \(value2):
                  a) \(value1 == value2) that are equal, and
                  b) \(value1.signum() == value2.signum()) that share the same sign, and
                  c) \(value1.trailingZeroBitCount == value2.trailingZeroBitCount) that have the same number of trailing zero bits
                  """)
        }
    }
}

//: - MARK: Callout(Exercise3):
//: Create an instance of `IntsAnalyzer`, then call the `analyzeInts` function.

let analyticka = IntsAnalyzer(value1: 777, value2: 10)
analyticka.analyzeInts()

//: [Next](@next)
