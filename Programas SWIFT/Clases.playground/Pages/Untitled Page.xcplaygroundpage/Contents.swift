//: Playground - noun: a place where people can play

import UIKit

class Alumno{
    var numCuenta: String //Es necesario inicializarlo por manejar referencias
    var nombre: String
    fileprivate var sexo: String
    var edad: Int{
        willSet{ //Willset verifica cuando se cambia la propiedad
            print("El nuevo valor: \(newValue)")
        }
    
        didSet{ //Cuando el valor ya fue modificado
            print("Valor actual: \(edad)")
        }
    }
    
    init(numCuenta: String){
        self.numCuenta = numCuenta
        self.nombre = "nadie"
        self.sexo = "M"
        self.edad = 0
        print("Constructor padre")
    }
    
    func estudia(){
        print("Nahh no estudia")
    }
}

class Ingenieria: Alumno{
    override func estudia() {
        print("yo si estudio")
    }
    override init(numCuenta: String){
        super.init(numCuenta: numCuenta)
        self.numCuenta = numCuenta
        print("Constructor hijo")
    }
}
class Contaduria: Alumno{
    
}
struct Profesor{
    var numEmpleo: String //NO necesita inicializador por lo mismo de valor/Referencia
}

var marduk = Profesor(numEmpleo: "0000000")
var parrita = Alumno(numCuenta: "9999999")
var german = parrita
var raul = Ingenieria(numCuenta: "23")
german.numCuenta = "8888888"
parrita.numCuenta
raul.estudia()
raul.edad = 24
raul.edad = 25



