//: [Previous](@previous)

import Foundation

//Enum para modelar estados:
enum EstadoDocumento: Int {
    case Recibido = 0, Validado, EnProceso, Publicado
}

let valorEstado = EstadoDocumento.Validado.rawValue
let estado = EstadoDocumento(rawValue: 1)


//
enum ResultadoWebService {
    case Exito(String)
    case Error(Int)
}

func llamadaWS() -> ResultadoWebService {
    if true {
        return ResultadoWebService.Exito("Mi conteniedo")
    }else{
        return ResultadoWebService.Error(502)
    }
}

let resultado: ResultadoWebService = llamadaWS()
switch resultado {
case let .Exito(contenido):
    print("contenido")
case let .Error(codigo):
    print("El código de error es \(codigo)")
}
//: [Next](@next)
