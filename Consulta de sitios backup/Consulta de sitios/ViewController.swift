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
    

       //@IBAction weak var accessButton: UIButton!
    
    @IBAction func login(_ sender: UIButton) {
        
        print("Accede"+userTxt.text!+","+passTxt.text!)
        
        let user = User(email: "admin@example.com", password: "tacocat1234")
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "ioslab.herokuapp.com"
        components.path = "/auth"
        
        var req = URLRequest(url: components.url!)
        // httpMethod is an string variable that must
        // conform any of the http protocol methods:
        // GET, POST, PUT, PATCH, DELETE, HEADER, OPTIONS
        // default is GET
        req.httpMethod = "POST"
        
        // httpBody a variable that conform the request body
        // as an optional data
        // default is nil
        print(user)
         req.httpBody = try? JSONEncoder().encode(user)
        
        // For authorization via header
        // you can set values with the addValue method
        //req.addValue("Basic 19c48aff0dae4a20b5dd2eb322ae37a2", forHTTPHeaderField: "Authorization")
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: req, completionHandler: { (data, response, error) in
            guard error == nil else {
                print("ERROR: \(error!)")
                return
            }
            guard let unwrappedData = data else {
                print("Empty response")
                return
            }
            
            let resp = response as! HTTPURLResponse
            if resp.statusCode == 200 {
                do {
                    let parsedJson = try JSONDecoder().decode(Token.self, from: unwrappedData)
                    
                    
                    print("Conexion correcta")
                    
                    print(parsedJson.token)
                    
                    
                    
                    /********************************/
                    let user = User(email: "admin@example.com", password: "tacocat1234")
                    
                    var components = URLComponents()
                    components.scheme = "https"
                    components.host = "ioslab.herokuapp.com"
                    components.path = "/auth"
                    
                    var req = URLRequest(url: components.url!)
                    // httpMethod is an string variable that must
                    // conform any of the http protocol methods:
                    // GET, POST, PUT, PATCH, DELETE, HEADER, OPTIONS
                    // default is GET
                    req.httpMethod = "POST"
                    
                    // httpBody a variable that conform the request body
                    // as an optional data
                    // default is nil
                    print(user)
                    req.httpBody = try? JSONEncoder().encode(user)
                    
                    // For authorization via header
                    // you can set values with the addValue method
                    //req.addValue("Basic 19c48aff0dae4a20b5dd2eb322ae37a2", forHTTPHeaderField: "Authorization")
                    req.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    let session = URLSession.shared
                    let task = session.dataTask(with: req, completionHandler: { (data, response, error) in
                        guard error == nil else {
                            print("ERROR: \(error!)")
                            return
                        }
                        guard let unwrappedData = data else {
                            print("Empty response")
                            return
                        }
                        
                        let resp = response as! HTTPURLResponse
                        if resp.statusCode == 200 {
                            do {
                                let parsedJson = try JSONDecoder().decode(Token.self, from: unwrappedData)
                                
                                
                                print("Conexion correcta")
                                
                                print(parsedJson.token)
                                
                                
                                /******************************/
                                //
                                /******************************/
                                
                                var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                                let subfolder = "AVirus"
                                url.appendPathComponent(subfolder)
                                
                                let json = try JSONEncoder().encode(parsedJson)
                                try json.write(to: url)
                                
                            } catch let err {
                                print("Unable to parse JSON: \(err)")
                            }
                        } else {
                            print("Unsuccesful request: \(resp)")
                        }
                    })
                    task.resume()
                    
                    
                    /********************************/
                    
                    
                    var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let subfolder = "AVirus"
                    url.appendPathComponent(subfolder)
                    
                    let json = try JSONEncoder().encode(parsedJson)
                    try json.write(to: url)
                    
                } catch let err {
                    print("Unable to parse JSON: \(err)")
                }
            } else {
                print("Unsuccesful request: \(resp)")
            }
        })
        task.resume()
        

                let alert = UIAlertController(title: "¿Almacenar credenciales?", message: "¿Deseas guardar tus credenciales para iniciar sesión?", preferredStyle: .alert)
        
                let okAction = UIAlertAction(title: "Si", style: .default) { action in
                    debugPrint(action)
                    //Creacion de un usuario
                    
                    //Lectura de archivo
                    let toky:Token
                    var url2 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let subfolder2 = "AVirus"
                    url2.appendPathComponent(subfolder2)
                    /*if let data2 = try? Data(contentsOf: url2){
                        try? JSONDecoder().decode(<Codable>.self, from: data)
                    }*/
                    
                    
                    
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
    


