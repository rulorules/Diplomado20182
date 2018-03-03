//: Playground - noun: a place where people can play

import UIKit

//:Optionals

var variable: String?
variable = nil

print(variable)
variable = "hola"
print(variable)
print(variable!) //NO hacer esto a menos de que estemos seguros que hay un valor en la variable

//: OPtional binding
variable = nil
if let saludo = variable{
    print("Saludo \(saludo)")
}else{
    print("No hay nada")
}


variable = "hi"
func saludos(cadena: String?){
    guard let saludo = cadena else{
        print("no hubo saludo")
        return
    }
    print("te salude")
}

saludos(cadena: variable)

//: Nil coalescing
var edad: Int? = 24
edad = nil
var edadValida = edad ?? 18
print(edadValida)


