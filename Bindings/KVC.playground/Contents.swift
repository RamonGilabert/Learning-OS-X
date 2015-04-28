import Cocoa

class Student: NSObject {
    var name = ""
    var gradeLevel = 0
}

let firstStudent = Student()
firstStudent.setValue("Kelly", forKey: "name")
firstStudent.setValue(3, forKey: "gradeLevel")

firstStudent.name
firstStudent.gradeLevel