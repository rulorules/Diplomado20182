//: [Previous](@previous)

import Foundation
//Funciones

func funcion(valor: Int){
    print(valor)
}

funcion(valor: 10)
func sinNombrarParametros(_ valor:Int){
    print(valor)
}

sinNombrarParametros(11)

func renombrarParametros(otroNombre valor:Int){
    print(valor)
}

renombrarParametros(otroNombre: 12)
//: [Next](@next)

func multiplica(_ x:Int, por y:Int) -> Int{
    return x * y
}

print(multiplica(5, por: 10))

func divide (_ x: Int, entre y:Int) -> (resultado: Int, residuo: Int){
    return (x/y,x%y)
}

let resultados = divide(17, entre: 4)
print(resultados.resultado)
print(resultados.residuo)

//Complicada
func suma(a: inout Int){
    a += 1
    print(a)
}

var numero = 4
suma(a: &numero)
print(numero)
//OJO, CAMBIA EL VALOR YA QUE MODIFICAMOS EN SU DIRECCION DE MEMORIA


//Overloading, sobrecarga de metodos
func getValue(_ x: Int) -> Int{
    return x
}
func getValue(_ x: String) -> String{
    return x
}

var x = getValue("Cadena")
print(x)

func PaisdelNunca() -> Never{
    while true{
        //Tira error si uso otra cosa que no sea una iteracion
    }
}



