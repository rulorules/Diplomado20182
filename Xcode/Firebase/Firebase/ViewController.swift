//
//  ViewController.swift
//  Firebase
//
//  Created by d182_raul_j on 05/05/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {

    var ref: DatabaseReference!
    
    
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
        btn.backgroundColor = UIColor(red: 232/255, green: 173/255, blue: 72/255, alpha: 1.0)
        
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
        let sg = UISegmentedControl(items: ["Login","Register"])
        sg.translatesAutoresizingMaskIntoConstraints = false
        sg.selectedSegmentIndex = 1
        sg.tintColor = UIColor.white
        
        //Sensa en que botom hacemos el clic y segmentedChange cambia el texto del boton
        sg.addTarget(self, action: #selector(segmentedChange), for: .valueChanged)
        return sg
    }()
    
    @objc func segmentedChange(){
        let title = formSegmentedControl.titleForSegment(at: formSegmentedControl.selectedSegmentIndex)
        
        registerButton.setTitle(title, for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 30/255, green: 62/255, blue: 106/255, alpha: 1)
        
        setupLayout()
        
        ref = Database.database().reference()
    }
    
    func setupLayout(){
        view.addSubview(formContainerView)
        view.addSubview(registerButton)
        formContainerView.addSubview(emailTextField)
        formContainerView.addSubview(passwordTextField)
        view.addSubview(formSegmentedControl)
        /**Contenedor*************/
        //Centrar la vista en x y en y
        formContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        formContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
    
    @objc func loginRegister(){
        if formSegmentedControl.selectedSegmentIndex == 0{
            loginUser()
        }else{
            registerUser()
        }
    }
    
    func loginUser(){
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
        }
    }
    
    func registerUser(){
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
        }
    }
    
    
    

}

