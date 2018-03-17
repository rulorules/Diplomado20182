//: Playground - noun: a place where people can play

import UIKit
class Person{
    var firstName: String
    var lastName: String
    var age: Int
    var id: Int
    static var count: Int = 0
    
    init(firstName: String, lastName: String){
        self.firstName = firstName
        self.lastName = lastName
        self.age = 0
        Person.count = Person.count + 1
        self.id = Person.count + 1
    }
    
    static func < (left: Person, right: Person) -> Bool{
        return left.age < right.age
    }
    static func += (left: Person, right: Int){
         left.age += right
    }
    
    init?(age: Int){ //Construtor falible
        self.firstName = "Sin nombre"
        self.lastName = "Sin apellido"
        self.age = age
        return nil
    }
    /*required init(age: Int){
        self.firstName = "nobody"
        self.lastName = "nobody"
        self.age = age
        self.id = 0
    }*/
    /*var id: Int{
        Person.count = Person.count + 1
        return Person.count
    }*/
}
class Student: Person{
    weak var partner: Student?
    deinit{
        print("\(firstName) fuera...")
    }
}

var parra: Student? = Student(firstName: "Parra", lastName: "Parrita")
var julio: Student? = Student(firstName: "Julio", lastName: "Julito")
var pepe: Student? = Student(age: 33)
parra?.partner = julio
julio?.partner = parra
pepe?.partner = julio
//julio = nil
//parra = nil
//pepe = nil
parra?.id
julio?.id

//parra < julio







