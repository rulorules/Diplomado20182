//: [Previous](@previous)

import Foundation

class Cartera{
    var dinero: Double
    var abonado: Double {
        get{
            print("Intereses actuales: \(dinero * 0.16) pesos")
            return dinero * 0.16
        }
        set{
            print("Se ha abonado: \(newValue)")
            dinero = (dinero * 0.16) + newValue
            print("Usted tiene: \(dinero)")
        }
    }
    init(dinero: Double, abonado: Double) {
        print("Creando una cartera con \(dinero) pesos")
        self.dinero = dinero
        self.abonado = abonado
    }
    
    deinit {
        print("Destruyendo una careta con \(dinero)")
    }
}


var carterita1 = Cartera(dinero: 23, abonado:200)
print(carterita1.abonado)
carterita1.abonado = 100
print(carterita1)
//: [Next](@next)
