//: Playground - noun: a place where people can play

import UIKit

//: Tuplas
var tupla: (Int, Int) = (3,5)
print(tupla.0)

var tupla2 = (20,30)
var coordenadas: (x: Int,y:  Int) = (x: 20, y:30)
print(coordenadas.x)

let (x, y) = coordenadas



//: Rangos

var rangos = 0 ... 10
var rangos2 = 0..<10
var rangos3 = (0...10).reversed()
var rangos4 = stride(from: 10, to: 100, by: 4)


