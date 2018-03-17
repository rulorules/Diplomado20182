//: [Previous](@previous)

import Foundation

//Clase, protocolo, extensiones

class Motito: Alumno, pintura{
    var color:String
    get{
    return "negro"
    }
    var wheels: Int{
        get{
            return 2
        }
    }
    func colorear(){
        print("pintar")
    }
    func acelerar(){
        print("Acelerar")
    }
    func frenar(){
        print("frenar")
    }
}
//: [Next](@next)
//Nota hay un protocolo Equatable
/*protocol Equatable{
    static func == (left: Self, right Self) -> Bool
}*
 
 protocol Comparable
 /
