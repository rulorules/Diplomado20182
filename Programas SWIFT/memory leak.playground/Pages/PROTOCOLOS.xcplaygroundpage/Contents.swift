//: [Previous](@previous)

import Foundation

//Ciertas acciones que se deben hacer obligatoriamenteacciones
protocol Vehiculo{
    var wheels : Int {get}
    func acelerar()
    func frenar()
}
protocol Tuning: Vehiculo {
    func rines(tipo: String)
}

protocol pintura{
    func colorear()
}
class Motito: Vehiculo, pintura{
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

protocol Reflexion{
var tipoReflexion: String{get}
}

extension String: Reflexion{
    var tipoReflexion: String{
        return "Muy pensativo el dia de hoy"
    }
}

let palabrita = "hola mundo"
palabrita.tipoReflexion
//: [Next](@next)
