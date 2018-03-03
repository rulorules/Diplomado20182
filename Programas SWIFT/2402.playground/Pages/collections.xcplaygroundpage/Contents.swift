//: [Previous](@previous)

import Foundation

//:Collections Array, Diccionarios, Conjuntos
var arreglo = [1,2,3,4,5,6]
let alumnos: [String] = []
let muchosCeros = Array(repeating: 0, count:100)

print(arreglo[1])
alumnos.isEmpty
arreglo.count
arreglo.first
arreglo.last
print(arreglo.last)
print(arreglo.last! as Any)

var arreglo2 = [2,3,4,5,6]
arreglo += arreglo
print(arreglo.sorted())
arreglo[1...4]
arreglo.contains(2)

for i in arreglo{
    print(i)
}
//: [Next](@next)
