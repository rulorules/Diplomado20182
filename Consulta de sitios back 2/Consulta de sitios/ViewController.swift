//
//  ViewController.swift
//  Consulta de sitios
//
//  Created by d182_raul_j on 02/03/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//
//Si la extension la haces al protocolo obligas a la clase a usarla
import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var userTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var checkBoxButton: UIButton!

       //@IBAction weak var accessButton: UIButton!
    
    @IBAction func login(_ sender: UIButton) {
        
        print("Accede"+userTxt.text!+","+passTxt.text!)
        /***Conexion******///
        let username = "ARREN\\TST01"
        let password = "JXF83V"
        var resultadoString = ""
        //let username = "ARREN\\"+userTxt.text!
        //let password = passTxt.text!
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString3 = loginData.base64EncodedString()
        
        if let someURL = URL(string: "https://apptelesitestest.azurewebsites.net/login") {
            var req = URLRequest(url: someURL)
            // This changes the HTTP method in the request line
            req.httpMethod = "GET"
            req.setValue("Basic \(base64LoginString3)", forHTTPHeaderField: "Authorization")
            req.setValue("2", forHTTPHeaderField: "AUTHMODE")

            NSURLConnection.sendAsynchronousRequest(req, queue: OperationQueue.main) {(response, data, error) in
                
                //print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
                var resultado = (NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
                print(resultado!)
                resultadoString = resultado! as String
                //if( resultado == "\"OK\""){
                    print("todo bien")
                let alert = UIAlertController(title: "¿Almacenar credenciales?", message: "¿Deseas guardar tus credenciales para iniciar sesión?", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Si", style: .default) { action in
                    debugPrint(action)
                    self.performSegue(withIdentifier: "Menu", sender: nil)
                }
                
                let cancelAction = UIAlertAction(title: "No", style: .destructive) { action in
                    debugPrint(action)
                    self.performSegue(withIdentifier: "Menu", sender: nil)
                }

                alert.addAction(okAction)
                                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
                
                //}
            }
        }
        /***Fin Conexion******///
 
    }
    
}

