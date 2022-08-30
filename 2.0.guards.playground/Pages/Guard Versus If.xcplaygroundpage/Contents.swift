//: [Previous](@previous)
//: ### Guard Versus If
//: While `guard` and `if` are similar, they should not be used interchangeably. Instead, it is recommended that:
        // **guard is used for preconditions (and early exit)** and
        // **if is used for changing the execution path**.
//: Using the flight example from before, notice the difference in how `guard` and `if` are used. When I chang ethe runwayShort parameter to false, final line of code is still printed out

func takeOff(passengersSeated: Bool, crewReady: Bool, runwayClear: Bool, runwayShort: Bool) {
    // are all preconditions met?
    guard passengersSeated, crewReady, runwayClear else { return }
    
    // (optional) if the runway is short, then enable high speed takeoff mode
    if runwayShort {
        print("💥 High speed takeoff enabled for airplane 1")
    }
    
    print("✈️ Lifts off runway for airplane 1")
}

takeOff(passengersSeated: true, crewReady: true, runwayClear: true, runwayShort: true)


// similar func from Udacity video:
func landing(passengersSeated: Bool, runwayClear: Bool, coPilot: String?) {
    guard passengersSeated, runwayClear else {return}
    
    // check if copilot is not nil?
    // notice that when I hold the option click on coPilotReadyConstant it is not nil any more
    // 2:51 change let to var,
    // 3:22 we have seen guard let and guard var, and there is another interesting property of these two keyword combinations, and that is that they behave like if let, in that we can ignore the unwrapped optional, use _. So sometimes you may want to check to make sure that the optional is not nil in guard statement but you do not really care about what the actual value is. To make this kind of check with guard just replace the name with underscore. So if the optional has a value, then the condition will be met and we will continue execution like we are doing now when we get to print statement. But if the optional is nil, then we exit early, and although it may not be obvious, if you thing about it for a bit, since we are ignoring the optional value now there is no way to reference it after the guard. 4:00,
    // guard var _ = coPilot else {
    // guard let coPilotConstant = coPilot else {
    guard var coPilotVariable = coPilot else {
        // print("\(coPilotConstant) is/not nil") // 1:29 Note1: Cannot find 'coPilotConstant' in scope, variable declared in guard condition is not usable in its body. Makes sence, if the unwrapping fails, we do not have a value to work with, it is nil.
        return}
    
    coPilotVariable = coPilotVariable.uppercased() // in case I do not change it, warning: Variable 'coPilotVariable' was never mutated; consider changing to 'let' constant
    
    // let coPilotConstant = "james" // 1:34 Note2: Invalid redeclaration of 'coPilotConstant'
    
    // the copilot is ready through this function:
    // print("\(coPilotConstant): Me as copilot I am ready for landing of airplane 2")
    print("\(coPilotVariable): Me as copilot I am ready for landing of airplane 2")
    print("airplane 2 is landing, informs \(coPilotVariable)")
}

landing(passengersSeated: true, runwayClear: true, coPilot: "👩🏻 Hanna Della Montagna")
// landing(passengersSeated: true, runwayClear: true, coPilot: nil) // no print statement

// 4:00 The last point I want to make is another one on style. Often you will find developers will reuse the name of an optional when using optional binding, and this happens for if let, guard let, and guard var. The reason is for conciseness. So here when we optionally are binding coPilotVariable or coPilotConstant, we are reusing the name coPilotVariable. The coPilotVariable that appears on on the left side of the equal sign that is an non optional, it is an actual string, Whereas the coPilot on the right side is the coPilot that is passed in as a parameter. It is an optional string. And to double check this we can option-click on coPilotVariable and coPilot that are on left and right sides of equal sign respectivelly.
// 4:39 Another nice way to think about this is that before the guard, coPilot is an optional, after the guard coPilotVariable is non optional.

//: Of course, there are situations where using `guard` or `if` may be less clear, and that's ok — this isn't an exact science. The best rule of thumb is to make sure code is readable and concise!
//:
enum Experience {
    case novice, expert
}

struct Pilot {
    var name: String
    var formerExperience: Experience
    var completedFlights: Int
}

func checkPilot1(pilot: Pilot) {
    // here, checking for experience creates multiple code paths
    if pilot.formerExperience == .novice {
        // guard is a precondition to check if the pilot is ready, otherwise early exit!
        guard pilot.completedFlights > 20 else { return }
        print("ready to fly, rookie 1?")
    } else if pilot.formerExperience == .expert {
        guard pilot.completedFlights > 5 else { return }
        print("you're up chief")
    }
}

func checkPilot2(_ pilot: Pilot) {
    // for conciseness, experience and completed flights could be checked at the same time
    if pilot.formerExperience == .novice && pilot.completedFlights > 20 {
        print("ready to fly, rookie 2?")
    } else if pilot.formerExperience == .expert && pilot.completedFlights > 5 {
        print("you're up chief")
    }
}

func checkPilot3(_ pilot: Pilot) {
    // a switch statement could also be used
    switch pilot.formerExperience {
    case .novice:
        guard pilot.completedFlights > 20 else { return }
        print("ready to fly, rookie?")
    case .expert:
        guard pilot.completedFlights > 5 else { return }
        print("you're up chief")
    }
}

let teddy = Pilot(name: "Teddy", formerExperience: .novice, completedFlights: 22)

checkPilot1(pilot: teddy)
checkPilot2(teddy)
checkPilot3(teddy)

// Emoji
    // https://www.iemoji.com/view/emoji/1339/skin-tones/woman-light-skin-tone

// 7 MARK: QUIZ Question 1:
// Will passStudent(_:) exit early when invoked?
    // a) function will exit early
    // b) function will not exit early, it will execute the print statement

struct Student {
    var name: String
    var grades: [Double]
    var average: Double {
        return grades.reduce(0) { return $0 + $1 } / Double(grades.count)
    }
}

func passStudent(_ student: Student?) {
    guard let student = student, student.average >= 75 else { return }
    print("\(student.name) passed!")
}

passStudent(Student(name: "Sam", grades: [70, 90, 84, 62, 88]))
// Sam passed with an average greater than 75! But 78.8 is cutting it a little too close! So b) is true

// 7 MARK: QUIZ Question 2:
// Will notifyUser(_:) exit early when invoked?
    // a) function will exit early
    // b) function will not exit early, it will execute the print statement

struct Studentessa {
    var name: String
    var grades: [Double]
    var topPassingGrade: Double? {
        let passingGrades = grades.filter { return $0 >= 75 }
        return passingGrades.max()
    }
}

func notifyUser(_ student: Studentessa) {
    guard let _ = student.topPassingGrade else { return }
    print("you've passed!")
}

notifyUser(Studentessa(name: "Ulysses", grades: [70, 60, 74, 76, 63]))
// That's right! Ulysses has one passing grade, a 76. Even though the value is ignored, it is enough to pass the conditional check and print “you’ve passed!”

//: [Next](@next)
