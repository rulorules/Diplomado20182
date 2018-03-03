//: [Previous](@previous)

import Foundation
var valor = 1
//Factorial
for i in 1...5{
    valor *= i
    print(valor)
}
print("Siguiente")

//Fibonacci
/*valor = 1
var anterior = 0
for _ in 0...4{
    
    valor = anterior + valor
    anterior = valor
    print(anterior)
}*/

var edad = 18
//SWITCH Y CASE
switch edad {
case 10:
    print("Muy chico")
case 18:
    print("Exacto")
default:
    break
}
edad = 20
switch edad {
case 0..<18:
    print("Muy chico")
case 18:
    print("Exacto")
default:
    print("Mayorcito")
}

var animal = "gato"
switch animal {
case "perro", "gato":
    print("animal doméstico")
default:
    print("ni idea")
}

var coord3D: (x:Int, y:Int, z:Int) = (x:0, y:13, z:0)
switch coord3D {
case (0,0,0):
    print("origen")
case (_,0,0):
    print("en X")
case (0,let y,0):
    print("En Y \(y)")
case (0,0,_):
    print("en Z")

default:
    break
}
//: [Next](@next)
