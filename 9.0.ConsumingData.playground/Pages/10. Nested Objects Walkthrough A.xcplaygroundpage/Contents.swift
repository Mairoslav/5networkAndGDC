//: [Previous](@previous)

import Foundation

// MARK: 10. Nested Objects Walkthrough A - as per my trial

/*
 // TODO: Nested JSON Practice
 It's time to practice parsing a JSON object with nested objects. Below, you'll see a JSON object used to represent a student, with several properties including a name, student ID, field of study, and letter grade.

 The name and student ID are at the root of the object. The field and grade are grouped under another JSON object, with the key "academics".

 Your task is to parse this JSON using your knowledge of nested structures, by performing the following steps:

 Create Codable structs for Student and Academics
 Give the Student struct a property for Academics, to match the JSON structure.
 Add the line to decode the result.
 It's recommended to print the parsed student object so you can verify that the JSON was decoded correctly.
 */

let json = """
{
    "name": "Alchemist",
    "student_ID": 135454,
    "academics": {
        "field_of_study": "ecology",
        "grade": 1
    }
}
""".data(using: .utf8)!

struct Academics: Codable {
    let field: String
    let grade: Int
    
    enum CodingKeys: String, CodingKey { // note: each non/nested JSON has to have its own enum
        case field = "field_of_study"
        case grade
    }
}

struct Student: Codable {
    let name: String
    let studentId: Int
    let academics: Academics
    
    enum CodingKeys: String, CodingKey { // note: each non/nested JSON has to have its own enum
        case name, academics // still even though academics has its own enum, case academics has to be here
        case studentId = "student_ID"
    }
}

do {
    let student = try JSONDecoder().decode(Student.self, from: json)
    print(student)
} catch {
    print(error)
}

//: [Next](@next)
