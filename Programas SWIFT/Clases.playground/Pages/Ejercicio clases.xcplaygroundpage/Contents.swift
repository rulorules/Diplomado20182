//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
/*Tengo un empleado con dos propiedades:
EL sueldo se obtiene al aplicar el iva
si el sueldo es igual o menor a cero que diga algo que no se puedo
si el descuento supera el sueldo que diga que no se puede
checar geters y steres setters en los usuarios, usar willset y didset
DEscuentos excesivos*/
class Empleado{

    var sueldo: Int{
        willSet{
            
                print("El nuevo valor: \(sueldo)")
            }
            didSet{
                print("Valor actual: \(sueldo)")
            }
        }
        var descuentos: Int{
            willSet{
                if(descuentos > sueldo){
                    print("El descuento es mayor: \(newValue)")
                }
                
                }
            
            didSet{
                print("Valor actual: \(sueldo)")
            }
        }
    
    init(sueldo: Int, descuentos: Int){
        self.sueldo = sueldo
        self.descuentos = descuentos
    }

    }

var German = Empleado(sueldo: 4, descuentos: 6)


