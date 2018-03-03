//: [Previous](@previous)

import Foundation

var valor = 0

for _ in 0...10{
    valor += 1
    //print(valor)
}
valor = 0
for i in 0...10 where i % 2 == 0{
    valor += 1
    print(i)
}
//: [Next](@next)
