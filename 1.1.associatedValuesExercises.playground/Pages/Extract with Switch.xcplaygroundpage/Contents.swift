//: [Previous](@previous)
//: ### Extract with Switch
//: The following exercises will use `AudioEffect`.
//:
enum AudioEffect {
    case rate(value: Double)
    case pitch(value: Double)
    case echo
    case reverb
}

let effect = AudioEffect.pitch(value: 0.5)
//: - Callout(Exercise):
//: Write a switch statement using the `effect` constant that extracts all possible associated values as constants. Print any extracted associated values.
//:
switch effect {
case .rate(let value):
    print("rate is \(value)")
case .pitch(let value):
    print("pitch is \(value)")
case .echo:
    print("echo")
case .reverb:
    print("reverb")
}
//: - Callout(Exercise):
//: Write a switch statement using the `effect` constant that ignores associated values.
//:
// or can skipp (_) totally
switch effect {
case .rate(_):
    print("rate")
case .pitch(_):
    print("pitch")
case .echo:
    print("echo")
case .reverb:
    print("reverb")
}
//: - Callout(Exercise):
//: Write a switch statement using the `effect` constant that extracts the associated value for `.rate` or `.pitch` into a variable. Then, divide the variable by half and print the resulting value. All other cases can be ignored using the default case.
//:
// my solution
switch effect {
case .rate(let rateValue):
    let halfRate = rateValue/2
    print("halfRate of given rate is \(halfRate)")
case .pitch(let pitchValue):
    let halfPitch = pitchValue/2
    print("halfPitch of given pitch is \(halfPitch)")
default:
    print("other cases are ignored")
}

// solution as per Udacity
switch effect {
case .rate(var value), .pitch(var value):
    value *= 0.5
    print(value)
default:
    break
}
//: - Callout(Exercise):
//: Write a switch statement using the `effect` constant that prints the associated value for `.pitch` only when it is greater than 0.4. Use the `where` keyword to complete this exercise (i.e. don't use an if statement). All other cases can be ignored using the default case.
//:
switch effect {
case .pitch(let value) where value > 0.4:
    print("yes pitch is now greater than 0.4, pitch is \(value)")
default:
    break
}
//: [Next](@next)
