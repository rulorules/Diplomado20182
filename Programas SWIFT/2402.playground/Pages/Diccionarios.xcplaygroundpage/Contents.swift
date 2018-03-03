//: [Previous](@previous)

import Foundation

//:Diccionarios

var diccionario = ["Pedro":18, "Ana": 22, "Juanito": 30]
print(diccionario["Pedro"]! as Any)

var alumnos: [String:Int] = [:]
alumnos.isEmpty
alumnos.count

var perfil = [
    "nombre" : "Parrita",
    "carrera" : "Admin"
]
print(perfil)
perfil.updateValue("CDMX",forKey: "Estado")
print(perfil)
perfil["Edad"] = "18"
print(perfil)
perfil.removeValue(forKey: "Edad")
perfil["Estado"] = nil
print(perfil)

for(llave, valor) in perfil{
    print("\(llave) - \(valor)")
}
for(llave) in perfil.keys{
    print("\(llave), ", terminator:"")
}

//Conjuntos
var conjunto:Set<Int> = [1, 2, 3, 1, 2]
print(conjunto)
//Libro con preguntas frecuentes del lenguajes de programacion
//goalkicker.com -> swift notes for professionals
//: [Next](@next)
