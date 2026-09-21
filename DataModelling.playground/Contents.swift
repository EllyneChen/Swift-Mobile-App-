import UIKit

struct Product {
    var name: String
    var price: Double
    var quality: Int
}

let product = Product(
    name: "laptop",
    price: 1200,
    quality: 2
)


//student app
struct Course{
    var name: String
}
struct Student{
    var name: String
    var course:[Course]}

let student = Student(
    name: "Ann",
    course: [
        Course(name: "Intro to Computer Science"),
        Course(name: "Mathematics"),
        Course(name: "Database Systems")
    ]
)


//Print Student
struct StudentStruct {
    var name : String
}

var student1 = StudentStruct(name: "Ann")
var student2 = student1

student2.name = "John"
print(student1.name)

class StudentClass {
    var name: String


init(name:String) {
    self.name = name
  }
}
let student3 = StudentClass(name:"Jack")
let student4 = student3

student3.name = "Jane"

print(student4.name) //John

