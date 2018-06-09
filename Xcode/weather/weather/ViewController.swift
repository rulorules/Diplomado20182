//
//  ViewController.swift
//  weather
//
//  Created by d182_raul_j on 03/03/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//ffa756dccfd4699dd19b042e99b027dd

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=London&units=metric&APPID=ffa756dccfd4699dd19b042e99b027dd")
        let task = URLSession.shared.dataTask(
            with: url!,
            completionHandler:{(data, response, error) in //funcion que se va a ejecutar si la peticion es exitosa
                if(data != nil){
                    do { //try catch
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] //Diccionario con llave string y valor any, oir ejemplo, cadena, enetero,flotante, etc.
                        DispatchQueue.main.async { //Todo lo que ocurre aqui se ejecutara en el hilo principal
                            if let main = json!["main"] as! [String: Any]? {
                                self.temperatureLabel.text = "\(main["temp"] as! Double)º C"
                            }
                            self.locationLabel.text = json!["name"] as? String
                        }
                    }catch let e {
                        print("Error retrieving weather data: \(e)");
                    }
                }
        }
        )
        
        task.resume() //Se ejecuta hasta aqui la tarea
    }

    //Ejercicios
    //1.-Hacerlo con una funcion
    //2.-Cambiar != nil as! y otrs para que quede mejor, poner mensaje de error en la conexion
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

