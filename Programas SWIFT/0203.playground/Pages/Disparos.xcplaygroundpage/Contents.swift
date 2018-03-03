//: [Previous](@previous)

import Foundation

//Escudos
//Conteo Balas disparadas si es > 10 -> armasobrecalentada = true -> el usuario no puede disparar despues de 10 segundos, las balas se resetea a 0
//Cada que se sobrecaliente, el escudo disminuye en un
//Cuando el escudo llegue a cero
//Arma Sobrecalentada

var conteoBalasDisparadas = 0
var armasobrecalentada = false
var escudo = 5
var gameOver = false

func dispara(){
    print("dispara")
    conteoBalasDisparadas = conteoBalasDisparadas + 1
    armaSobrecalentada(conteo: conteoBalasDisparadas)
}

func armaSobrecalentada(conteo: Int){
    if(conteo > 200){
        print("Arma sobrecalentara")
        sleep(10)
        conteoBalasDisparadas = 0
        pierdeEscudo(armaCaliente: true)
    }
}

func pierdeEscudo(armaCaliente: Bool){
        escudo = escudo - 1
        print("Pierde escudo")
        if(escudo == 0){
            gameOver = true
            print("game over")
        }
    }

while(!gameOver){
    dispara()
}

//: [Next](@next)
