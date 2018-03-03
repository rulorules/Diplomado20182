//: [Previous](@previous)

import Foundation

//Closure

var miClosure: (Int, Int) -> Int
var miClosure2: (Int, Int) -> Int
miClosure = {(a: Int, b:Int) -> Int in
    return a + b
}

miClosure2 = {(a: Int, b:Int) -> Int in
    return a * b
}


let resultado = miClosure(3,2)

func ejecutaOperacion(_ closure:(Int, Int) -> Int,a:Int, b:Int){
    let resultado = closure(a,b)
    print(resultado)
}

ejecutaOperacion(miClosure, a: 10, b: 20)
ejecutaOperacion(miClosure, a: 50, b: 5)

//ejecutaOperacion(a / b, a: 15, b: 30) //Dentro de su funcion los closures van hasta el final

miClosure = {(a,b) in
    a + b
}

miClosure = {
    $0 + $1
}

var otraFirmaSinRetornp: () -> Void = {
    print("No regresaré nada")
}
var closureSinRetorno: () -> Void = {
  print("no regresaré nada")
}


var numero = 0
func incrementa(variable: inout Int){
    variable += 1
}
incrementa(variable: &numero)

let incrementav2 = {
    numero += 1
}

incrementav2()
incrementav2()
incrementav2()
incrementav2()
numero

func incrementaClosure() -> () -> Int{ //funcion que regresa un closure que regresa un entero
    var contador = 0
    let incrementa: () -> Int = { //closure que regresa un entero
        contador += 1
        return contador
    }
    return incrementa
}

let contador1 = incrementaClosure()
let contador2 = incrementaClosure()
contador1()
contador1()
contador2()
contador1()


//Custom closures sobre closures existentes
let letras = ["Z","CCCC","MHHHHH","OOOOOOOOOO","Hiiiiiiiiiiii"]
letras.sorted()

print(letras.sorted(){
    $0.count > $1.count
})

letras.forEach{ String in
    print("\(String) ")
}
let numeros = [2.3,3.1,4.7,5.2,7.8,9.1,10]

numeros.forEach{
    print($0)
}


let filtrados = numeros.filter{
    return $0 > 5
}

print("Numeros filtrados: \(filtrados)")

let mapeados = numeros.map{
    return $0 * 10
}

print("Mapeados: \(mapeados)")

let letrasYNumeros = ["Hola", "0", "adios", "1", "3"]

let numerosUsuario = letrasYNumeros.flatMap{ //Cambiado de MAp
    Int($0)
}
print(numerosUsuario)

let total = numeros.reduce(0){
    return $0 + $1
}
print(total)

//: [Next](@next)

