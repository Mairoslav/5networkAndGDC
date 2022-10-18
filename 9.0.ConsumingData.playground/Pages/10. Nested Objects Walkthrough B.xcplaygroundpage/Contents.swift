//: [Previous](@previous)

import Foundation

// MARK: 10. Nested Objects Walkthrough B - as per lesson solution

let json = """
{
    "name": "Loretan",
    "studentId": 326156,
    "academics": {
        "field": "iOS",
        "grade": "A"
    }
}
""".data(using: .utf8)!

struct Academics: Codable {
    let field: String
    let grade: String
}

struct Student: Codable {
    let name: String
    let studentId: Int
    let academics: Academics
}

let decoder = JSONDecoder()
let student: Student

do {
    student = try decoder.decode(Student.self, from: json)
    print(student)
} catch {
    print(error)
}


//: [Next](@next)
