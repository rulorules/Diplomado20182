//: Playground - noun: a place where people can play

import UIKit

enum Dia {
    case Lunes
    case Martes
    case Miercoles
    case Jueves
    case Viernes
    case Sabado
    case Domingo
}

var diaSemana: Dia
diaSemana = .Lunes

switch diaSemana {
case .Lunes:
    print("Ya es lunes")
case .Martes:
    print("Ya es Martes")
case .Miercoles:
    print("Ya es Miercoles")
case .Jueves:
    print("Ya es jueves")
case .Viernes:
    print("Ya es viernes")
default: //Es recomendable no poner el default para cuando se usen enums!!
    print("Otro Dia de la semana")
}
