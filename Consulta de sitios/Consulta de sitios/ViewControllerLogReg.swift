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

class ViewControllerLogReg: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        //Carga las vistas
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /************************Elementos a dibujar en la pantalla***************************/
    let formContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        //Suaviza las esquinas con un radio
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let registerButton: UIButton = { //Closure
        let btn = UIButton(type: .system)
        //btn.backgroundColor = UIColor(red: 232/255, green: 173/255, blue: 72/255, alpha: 1.0)
        btn.backgroundColor = UIColor(red: 195/255, green: 1/255, blue: 1/255, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("Registro", for: .normal)
        
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        
        
        btn.addTarget(self, action: #selector(loginRegister), for: .touchUpInside)
        
        return btn
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Correo electrónico"
        //Constraints
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Contraseña"
        //Constraints
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    
    let formSegmentedControl : UISegmentedControl = {
        let sg = UISegmentedControl(items: ["Acceder","Register"])
        sg.translatesAutoresizingMaskIntoConstraints = false
        sg.selectedSegmentIndex = 1
        sg.tintColor = UIColor.white
        
        //Sensa en que botom hacemos el clic y segmentedChange cambia el texto del boton
        sg.addTarget(self, action: #selector(segmentedChange), for: .valueChanged)
        return sg
    }()

    
    func setupLayout(){
        view.addSubview(formContainerView)
        view.addSubview(registerButton)
        formContainerView.addSubview(emailTextField)
        formContainerView.addSubview(passwordTextField)
        view.addSubview(formSegmentedControl)
        /**Contenedor*************/
        //Centrar la vista en x y en y
        formContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        formContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -90).isActive = true
        //Le damos el ancho de la vista menos una constante de margen
        formContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        formContainerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        /*************************/
        
        /**Boton de registro******/
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: formContainerView.bottomAnchor, constant: 15).isActive = true
        registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        /*************************/
        
        /**Campo de correo******/
        emailTextField.leftAnchor.constraint(equalTo: formContainerView.leftAnchor, constant: 10).isActive = true
        emailTextField.topAnchor.constraint(equalTo: formContainerView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: formContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        /*************************/
        
        /**Campo de contraseña******/
        passwordTextField.leftAnchor.constraint(equalTo: formContainerView.leftAnchor, constant: 10).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: formContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        /*************************/
        
        /**form segmentado (dos botones)******/
        formSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        formSegmentedControl.bottomAnchor.constraint(equalTo: formContainerView.topAnchor, constant: -15).isActive = true
        formSegmentedControl.widthAnchor.constraint(equalTo: formContainerView.widthAnchor).isActive = true
        formSegmentedControl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        /*************************/
        
    }
    
    @objc func segmentedChange(){
        let title = formSegmentedControl.titleForSegment(at: formSegmentedControl.selectedSegmentIndex)
        
        registerButton.setTitle(title, for: .normal)
    }
    
    @objc func loginRegister(){
        if formSegmentedControl.selectedSegmentIndex == 0{
            loginUser()
        }else{
            registerUser()
        }
    }
    
    func loginUser(){
        
        let loginString = String(format: "%@:%@", "MANT\\indmantb", "Indep#17!")
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString3 = loginData.base64EncodedString()
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "apptelesitesprodu.azurewebsites.net"
        components.path = "/login"

        var req = URLRequest(url: components.url!)
        req.httpMethod = "GET"
        //req.addValue("Basic 19c48aff0dae4a20b5dd2eb322ae37a2", forHTTPHeaderField: "Authorization")
        req.setValue("Basic \(base64LoginString3)", forHTTPHeaderField: "Authorization")
        req.setValue("2", forHTTPHeaderField: "AUTHMODE")

        let session = URLSession.shared
        let task = session.dataTask(with: req, completionHandler: { (data, response, error) in
            let resultado = (NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
            print(resultado!)
            guard error == nil else {
                print("ERROR: \(error!)")
                return
            }
            guard data != nil else {
                print("Empty response")
                return
            }
            
            let resp = response as! HTTPURLResponse
            if resp.statusCode == 200 {
                print(resultado!)
            } else {
                print("Unsuccesful request: \(resp)")
            }
        })
        task.resume()
        performSegue(withIdentifier: "Opciones", sender: nil)
        /*
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if user != nil{
                    print("Usuario autenticado")
                    let lc = LoginViewController()
                    self.navigationController?.pushViewController(lc, animated: true)
                }else{
                    if let error = error?.localizedDescription{
                        print("Error al crear usuario por firebase", error)
                    }else{
                        print("Tu eres el error en sesion!!")
                    }
                }
            }
        }*/
    }
    
    
    func registerUser(){
        /*
        if let email = emailTextField.text,let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if user != nil{
                    print("Se creo el usuario")
                    
                    let values = ["name": email]
                    
                    guard let uid = user?.uid else{
                        return
                    }
                    //y entonces creamos una llave por usuario para que sean unicos
                    
                    let usersReference = self.ref.child("users").child(uid)
                    
                    usersReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                        if error != nil{
                            print("Error al insertar datos")
                            return
                        }else{
                            print("Dato guardado en la BD")
                        }
                    })
                    
                    let login = LoginViewController()
                    //Con esto no tenemos el boton de alir ya que no esta con el navigation controler
                    //self.present(login, animated: true,completion: nil)
                    self.navigationController?.pushViewController(login, animated: true)
                }else{
                    if let error = error?.localizedDescription{
                        print("Error al crear usuario por firebase", error)
                    }else{
                        print("Tu eres el error!!")
                    }
                }
            }
        }*/
    }
    /**********************************************************************/
    
    
    
    
    
    
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
                    //self.performSegue(withIdentifier: "Menu", sender: nil)
                }
                
                let cancelAction = UIAlertAction(title: "No", style: .destructive) { action in
                    debugPrint(action)
                    //self.performSegue(withIdentifier: "Menu", sender: nil)
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

