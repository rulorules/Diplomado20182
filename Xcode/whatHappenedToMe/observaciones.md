Raúl Rodolfo Jiménez Saavedra

1.- Al compilar desde un inicio manda un error en la línea de
class AppDelegate: UIResponder, UIApplicationDelegate { en AppDelegate.swift
Ni siquiera muestra errores en la sección de errores de compilación ni ejecución

2.- En Main.storyboard se observa que se crearon DOS botones, solo se puede observar uno por lo que es natural seleccionar el único botón visible y moverlo, de tal forma que se observa el segundo. En el código se observa que la variable del botón se llama “aoutletButton” por lo tanto se decide conservar ese y eliminar el otro.

3.- En el resumen de las conexiones se puede ver a aoutletButton con el botón Aoutlet Button
Y a outletText con Outlet Text, sin embargo la variable esta mal escrita, en el código esta con el nombre de outtletText y no tiene la referencia de que se esta declarando desde el storyboard @IBOutlet por lo que se corrige con el código:
@IBOutlet weak var outletText: UITextField!

4.- Al corregir esto aparece un nuevo error en viewController.swift el cual se soluciona volviendo a renombre la variable que se corrigió para la conexión

5.- Ya compila, sin embargo, al presionar no sucede nada además de que no se ve bien el texto de Touch me!

6.- Se hace la reacion del botón con su método, pero aún así el texto no cambia, se cambia el objeto de Text por un label y todos los errores quedaron corregidos.

 7.- Se probó con el simulador de iPhone 8, se colocó código para correr como portrait y se agregaron contraints para centrar bien las vistas.

Conclusiones:
La búsqueda de errores puede ser complicada y hasta cierto punto tomar más tiempo que rehacer un proyecto, sin embargo es necario aprender a realizarlo ya que muchas veces tendremos que tratar con código que no es nuestro y habrá que solucionar errores dejados por otros, esta clase de ejercicios ayuda no solo a aprender lo visto en la creación de la primer app sino también en esta búsqueda y solución de errores.
