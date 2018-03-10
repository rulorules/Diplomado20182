//: [Previous](@previous)

import Foundation

//tuplas -> emums -> estructuras ->

struct Cuerpo {
    var altura: Double = 0 //Propiedades con almacenamiento y valor por default
    var peso: Double = 0
}

//Las estructuras no soportan herencia

var cuerpo = Cuerpo()
cuerpo.altura = 1.72
cuerpo.peso = 80.0

var cuerpo2 = cuerpo
cuerpo.altura = 2.0
cuerpo2
//Se hace un paso por valor y no por referencia a diferencia de la clase
//: [Next](@next)
