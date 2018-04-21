//: Playground - noun: a place where people can play

import UIKit

/*
func swapInt( a:inout Int, b: inout Int){
    let temp = a
    a = b
    b = temp
}

func swapString( a:inout String, b: inout String){
    let temp = a
    a = b
    b = temp
}
*/

func swapGeneric<T>( a:inout T, b: inout T){
    let temp = a
    a = b
    b = temp
}
var a = 5
var b = 10
swapGeneric(a: &a, b: &b)
print("\(a) - \(b)")


//Implementa el protocola comparable
func GenericEqual<T : Comparable>( a: T, b: T) -> Bool{
    return a == b
}

struct Lista<T>{
    var items = [T]()
    mutating func add(item: T){
        items.append(item)
    }
    
    func getItemAtIndex(index: Int) -> T?{
        if items.count > index{
            return items[index]
        }else{
            return nil
        }
    }
    
    subscript(index: Int) -> T?{
        return getItemAtIndex(index: index)
    }
    
    subscript(r: CountableClosedRange<Int>) -> [T]?{
        get{
            return Array(items[r.lowerBound ... r.upperBound])
        }
    }
    
}
var milista = Lista<String>()
milista.add(item: "uno")
milista.add(item: "dos")
milista.add(item: "tres")

print(milista.getItemAtIndex(index: 1)!)


var myList = Lista<Int>()
myList.add(item: 3)
myList.add(item: 7)
myList.add(item: 29)
myList.add(item: 13)
myList.add(item: 58)
var valores = myList[1] //para poder manejarlo asi sirve la funcion subscript, se evita poner MyList.items[2]
print(valores!)
var valores2 = myList[2...4] //para poder manejarlo asi sirve la funcion subscript, se evita poner MyList.items[2]
print(valores2!)

class generica<T, E>{
}
let objetoGenerico = generica<String,Int>()
enum enumGenerico<T>{
}

