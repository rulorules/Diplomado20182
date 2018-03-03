//: [Previous](@previous)

import Foundation

/*****
 Raúl Rodolfo Jiménez Saavedra
 Algoritmos primo, fibonacci, primo y fibonacci, palíndromo y cadenas con los mismos caracteres
 ******/


/***Primo por Raúl*****/
func EsPrimo(numero: Int) -> Bool {
    var resultado = true
    if(numero < 1){
        resultado = false
    }else if(numero <= 3){
        resultado = true
    }else if(numero % 2 == 0 || numero % 3 == 0){
        resultado = false
    }
    var i = 5
    while i*i < numero {
        if(numero % i == 0 || numero % (i + 2) == 0){
            return false
        }
        i = i + 6
    }
    return resultado
}

/*****Primo por German*****/
/*********/

EsPrimo(numero: 4)
/****Fibonacci*****/

func Fibonacci(numero: Int) -> Int{
    
    if(numero < 2){
        return numero
    }else{
        return Fibonacci(numero: numero - 1) + Fibonacci(numero: numero - 2)
    }
}
for index in 1...9{
    print(Fibonacci(numero: index))
    
}


/*****Fibonacci por GERMAN*****/
func fibonacciGerman(n : Int){
    var a = 0, b = 1
    var i = 0
    while i < n{
        print(b)
        (a, b) = (b, a + b)
        i += 1
    }
}
fibonacciGerman(n: 5)
/**********/

/****Fibonacci y primo*****/
print("-------------")
/*for index in 1...10{
 if(EsPrimo(numero: index)){
 print(Fibonacci(numero: index))
 }
 
 
 }*/

/***********ES PALINDROMO***********/
func EsPalindromo(cadena: String) -> Bool {
    //reversa = cadena.reversed()
    if(String(cadena.reversed()) == cadena){
        return true
    }else{
        return false
    }
    
}
/**********Palíndromo por German*********/
func palindromoGerman(cadena: String) -> Bool{
    return cadena == String(cadena.reversed())
}
/*******************/
/*:
 ## Probando marks
 */
EsPalindromo(cadena: "ana")

/********TIENE LOS MISMOS CARACTERES*************/
//Usar sort
func TienenLosMismosCaracteres(cadena1: String,cadena2: String) -> Bool {
    if (String(cadena1.sorted()) == String(cadena2.sorted())){
        return true
    }else{
        return false
    }
}
TienenLosMismosCaracteres(cadena1: "hola", cadena2: "aloh")
/********TIENE LOS MISMOS CARACTERES por german**********/
/*
func iguales(cadena1: String, cadena2: String) -> Bool{
    return cadena1.count == cadena2.count && cadena1.count ==
}
*/

//: [Next](@next)

