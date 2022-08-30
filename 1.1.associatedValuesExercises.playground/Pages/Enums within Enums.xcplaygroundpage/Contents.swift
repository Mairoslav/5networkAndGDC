//: [Previous](@previous)
//: ### Enums within Enums
//: - Callout(Exercise):
//: Define an enum called `SConfig` representing the different configurations for the 2017 Tesla Model S vehicle. Use a raw type (Double) to represent its starting price in USD. The following image contains the possible configurations:
//:
//: ![model-s](/modelS.png)
//:
enum SConfig: Double {
    case sixty = 68_000, sixtyD = 73_000
    case seventyFive = 79_500, seventyFiveD = 74_500
    case ninetyD = 87_500
    case hundredD = 94_000, pHundredD = 135_000
}
//: - Callout(Exercise):
//: Define an enum called `XConfig` representing the different configurations for the 2017 Tesla Model X vehicle. Use a raw type (Double) to represent its starting price in USD. The following image contains the possible configurations:
//:
//: ![model-s](/modelX.png)
//:
enum XConfig: Double {
    case seventyFiveD = 79_500
    case ninetyD = 93_500
    case hundredD = 96_000, pHundredD = 140_000
}
//: - Callout(Exercise):
//: Define an enum called `ThreeType` representing the different types for the 2017 Tesla 3 vehicle. Use a raw type (Double) to represent its starting price in USD. The following image contains the possible types:
//:
//: ![model-s](/model3.png)
//:
enum ThreeType: Double {
    case standard = 35_000
    case longRange = 44_000
}
//: - Callout(Exercise):
//: Define an enum called `Tesla2017` representing Tesla's cars for 2017 — the Model S, Model X, and Model 3. Each case (car) should have an associated value for the different configuration or type for that model. Create a constant called `newCar` that is a Standard Tesla 2017 Model 3.
//:
// solution as I wrote
enum TeslaModels2017 {
    case modelS(modelTypesS: [SConfig])
    case modelX(modelTypesX: [XConfig])
    case model3(model3Types: [ThreeType])
}

let veryNewCar = TeslaModels2017.model3(model3Types: [.standard])

// solution by Udacity, works also shortened without config:, type:
enum Tesla2017 {
    case modelS(config: SConfig)
    case modelX(config: XConfig)
    case model3(type:ThreeType)
}

let newCar = Tesla2017.modelS(config: .pHundredD)
// Tesla2017.model3(type: .standard) // (type: .standard)
//: - Callout(Exercise):
//: Use a switch statement to extract and print the starting the value for `newCar`. The switch statement should be able to handle any type of Tesla 2017 model.
//:
// solution as I wrote
switch newCar {
case let .model3(type):
    print("price of \(type) is \(type.rawValue)")
default:
    break
}

// solution by Udacity, covering all models/types:
switch newCar {
case let .modelS(config):
    print("price of configuration \(config) is \(config.rawValue) $")
case let .modelX(config):
    print("price of configuration \(config) is \(config.rawValue) $")
case let .model3(type):
    print("price of type \(type) is \(type.rawValue) $")
}
