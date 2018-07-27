//
//  UploadSiteViewController.swift
//  Consulta de sitios
//
//  Created by Jorge Alba on 23/07/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit

class UploadSiteViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,ChildViewControllerDelegate{
    var pickerDataSource = ["Restaurante", "Museo", "Comida rápida", "Bar"];
    var pickerDataSourceCost = ["$", "$$", "$$$"];
    var selectedLatitude = 0.0
    
    func childViewControllerResponse(type: [String])
    {
         // self.parameter = parameter
        latitudeField.text = type[0]
        longitudeField.text = type[1]
        latitudeField.isUserInteractionEnabled = false
        longitudeField.isUserInteractionEnabled = false
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        
        view.addGestureRecognizer(tap)
        //pickerView.dataSource = self;
        //pickerView.delegate = self;
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func UploadSite(_ sender: UIButton) {
        print("subiendo...")
    }

    let formContainerView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        //Suaviza las esquinas con un radio
        //view.layer.cornerRadius = 10
        //view.layer.masksToBounds = true
        return view
    }()
    let siteNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Nombre del lugar"
        //Constraints
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    let latitudeField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Latitud"
        //Constraints
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = UIKeyboardType.decimalPad
        return tf
    }()
    
    let longitudeField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Longitud"
        //Constraints
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = UIKeyboardType.decimalPad
        return tf
    }()
    
    let LabelField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Etiqueta"
        //Constraints
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let sendButton: UIButton = { //Closure
        let btn = UIButton(type: .system)
        //btn.backgroundColor = UIColor(red: 232/255, green: 173/255, blue: 72/255, alpha: 1.0)
        btn.backgroundColor = UIColor(red: 195/255, green: 1/255, blue: 1/255, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("Subir lugar", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(upload), for: .touchUpInside)
        return btn
    }()
    
    
    let coordsButton: UIButton = { //Closure
        let btn = UIButton(type: .system)
        //btn.backgroundColor = UIColor(red: 232/255, green: 173/255, blue: 72/255, alpha: 1.0)
        btn.backgroundColor =  UIColor.clear
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        
        //btn.layer.borderWidth = 2.0
        //btn.layer.borderColor = UIColor.black.cgColor;
        let image = UIImage(named: "find-on-map") as UIImage?
        //let button   = UIButton(type: UIButtonType.Custom) as UIButton
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        btn.setImage(image, for: .normal)
        btn.addTarget(self, action: #selector(selectCoord), for: .touchUpInside)
        return btn
    }()
    
    let LabelButton: UIButton = { //Closure
        let btn = UIButton(type: .system)
        //btn.backgroundColor = UIColor(red: 232/255, green: 173/255, blue: 72/255, alpha: 1.0)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.white, for: .normal)
        
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        
        
        let image = UIImage(named: "plus") as UIImage?
        //let button   = UIButton(type: UIButtonType.Custom) as UIButton
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        btn.setImage(image, for: .normal)
        btn.addTarget(self, action: #selector(addLabel), for: .touchUpInside)
        return btn
    }()
    
    let AllLabelsField: UILabel = {
        let tf = UILabel()
        //Constraints
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = ""
        return tf
    }()
    
    let CategoryPicker: UIPickerView = {
        let tf = UIPickerView()
        //Constraints
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.showsSelectionIndicator = true
        //tf.delegate = self
        //tf.dataSource = self
        //view.addSubview(tf)
        return tf
    }()
    
    let DescriptionField: UITextField = {
        let tf = UITextField()
        //Constraints
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Descripción del sitio"
        return tf
    }()
    
    func setupLayout()
    {
        view.addSubview(formContainerView)
        //view.addSubview(registerButton)
        formContainerView.addSubview(siteNameTextField)
        formContainerView.addSubview(latitudeField)
        formContainerView.addSubview(longitudeField)
        formContainerView.addSubview(coordsButton)
        formContainerView.addSubview(LabelField)
        formContainerView.addSubview(LabelButton)
        formContainerView.addSubview(AllLabelsField)
        CategoryPicker.delegate = self
        CategoryPicker.dataSource = self
        formContainerView.addSubview(CategoryPicker)
        formContainerView.addSubview(DescriptionField)
        formContainerView.addSubview(sendButton)
        
        
        formContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        formContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        formContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        formContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        /**Campo de correo******/
        siteNameTextField.leadingAnchor.constraint(equalTo: formContainerView.leadingAnchor, constant: 16).isActive = true
        siteNameTextField.topAnchor.constraint(equalTo: formContainerView.topAnchor, constant: 26).isActive = true
        
        /*************************/
        
        /**Campo de contraseña******/
        latitudeField.leadingAnchor.constraint(equalTo: formContainerView.leadingAnchor, constant: 16).isActive = true
        latitudeField.topAnchor.constraint(equalTo: siteNameTextField.bottomAnchor, constant: 20).isActive = true
        //latitudeField.widthAnchor.constraint(equalTo: formContainerView.widthAnchor).isActive = true
        //longitudeField.widthAnchor.constraint(equalToConstant: 2000).isActive = true
        //passwordTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        /*************************/
        
        /**Campo de contraseña******/
        longitudeField.leadingAnchor.constraint(equalTo: formContainerView.leadingAnchor, constant: 16).isActive = true
        longitudeField.topAnchor.constraint(equalTo: latitudeField.bottomAnchor, constant: 20).isActive = true
        //longitudeField.widthAnchor.constraint(equalTo: formContainerView.widthAnchor).isActive = true
        //longitudeField.widthAnchor.constraint(equalToConstant: 3000).isActive = true
        //passwordTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        /*************************/
        
        /**Botón coordenadas*******/
        //coordsButton.leadingAnchor.constraint(equalTo: latitudeField.trailingAnchor, constant: 200).isActive = true
        coordsButton.trailingAnchor.constraint(equalTo: formContainerView.trailingAnchor, constant: 20).isActive = true
        coordsButton.topAnchor.constraint(equalTo: siteNameTextField.bottomAnchor, constant: 25).isActive = true
        coordsButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        /*************************/
        
        /**Campo de etiquetas******/
        LabelField.leadingAnchor.constraint(equalTo: formContainerView.leadingAnchor, constant: 16).isActive = true
        LabelField.topAnchor.constraint(equalTo: longitudeField.bottomAnchor, constant: 60).isActive = true
        //LabelField.widthAnchor.constraint(equalToConstant: 3000).isActive = true
        /*************************/
        
        /**Botón coordenadas*******/
        LabelButton.leadingAnchor.constraint(equalTo: LabelField.trailingAnchor, constant: 200).isActive = true
        LabelButton.trailingAnchor.constraint(equalTo: formContainerView.trailingAnchor, constant: 20).isActive = true
        //LabelButton.topAnchor.constraint(equalTo: longitudeField.bottomAnchor, constant: 25).isActive = true
        LabelButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        LabelButton.centerYAnchor.constraint(equalTo: LabelField.centerYAnchor).isActive = true
        /*************************/
        
        /**Texto de etiquetas agregadas***/
        AllLabelsField.leftAnchor.constraint(equalTo: formContainerView.leftAnchor, constant:16).isActive = true
        AllLabelsField.topAnchor.constraint(equalTo: LabelField.bottomAnchor, constant: 20).isActive = true
        AllLabelsField.rightAnchor.constraint(equalTo: formContainerView.rightAnchor).isActive = true
        /**************************/
        
        /**Categorias***/
        CategoryPicker.leftAnchor.constraint(equalTo: formContainerView.leftAnchor, constant:16).isActive = true
        CategoryPicker.topAnchor.constraint(equalTo: AllLabelsField.bottomAnchor, constant:-16).isActive = true
        CategoryPicker.rightAnchor.constraint(equalTo: formContainerView.rightAnchor).isActive = true
        /**************************/
        
        /**Texto de descripcion***/
        DescriptionField.leftAnchor.constraint(equalTo: formContainerView.leftAnchor, constant:16).isActive = true
        DescriptionField.topAnchor.constraint(equalTo: CategoryPicker.bottomAnchor, constant:-16).isActive = true
        DescriptionField.rightAnchor.constraint(equalTo: formContainerView.rightAnchor).isActive = true
        DescriptionField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        /**************************/
        
        /**************************/
        /**Boton de envio******/
        sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendButton.topAnchor.constraint(equalTo: DescriptionField.bottomAnchor, constant: 15).isActive = true
        sendButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        /*************************/
        formContainerView.bottomAnchor.constraint(equalTo: sendButton.bottomAnchor).isActive = true
    }
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        DescriptionField.resignFirstResponder()
        siteNameTextField.resignFirstResponder()
        latitudeField.resignFirstResponder()
        longitudeField.resignFirstResponder()
        LabelField.resignFirstResponder()
    }
    
    @objc func upload(){
        
        var cadena = "";
        cadena = cadena + siteNameTextField.text! + "|"
        cadena = cadena + latitudeField.text! + "|"
        cadena = cadena + longitudeField.text! + "|"
        cadena = cadena + AllLabelsField.text! + "|"
        cadena = cadena + pickerView(CategoryPicker, titleForRow: CategoryPicker.selectedRow(inComponent: 0), forComponent: 0)! + "|"
        cadena = cadena + DescriptionField.text!
        print(cadena)
        let email = "Prueba14"
        let password = "Prueba14"
        let loginString = String(format: "%@:%@", "ARREN\\" + email, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString3 = loginData.base64EncodedString()
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "apptelesitestest.azurewebsites.net"
        components.path = "/postArt"
        
        var req = URLRequest(url: components.url!)
        req.httpMethod = "POST"
        //req.addValue("Basic 19c48aff0dae4a20b5dd2eb322ae37a2", forHTTPHeaderField: "Authorization")
        req.setValue("Basic \(base64LoginString3)", forHTTPHeaderField: "Authorization")
        req.setValue("2", forHTTPHeaderField: "AUTHMODE")
        let postString = cadena
        req.httpBody = postString.data(using: .utf8)
        
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
                //      (withIdentifier: "Opciones", sender: nil)
                DispatchQueue.main.async {
                    let alert2 = UIAlertController(title: "Sitio agregado exitosamente", message: "Tu sitio ahora esta en el mapa", preferredStyle: .alert)

                    let okAction3 = UIAlertAction(title: "Ok", style: .cancel) { action in
                        //self.performSegue(withIdentifier: "Opciones", sender: nil)
                    }
                    alert2.addAction(okAction3)
                    self.present(alert2, animated: true, completion: nil)
                    print("sitio subido exitosamente")
                    _ = self.navigationController?.popViewController(animated: true)
                }
            } else {
                print("Unsuccesful request: \(resp)")
                DispatchQueue.main.async {
                    let alert2 = UIAlertController(title: "Error en inicio de sesión", message: "Ocurrio un error al iniciar sesión, intentalo de nuevo", preferredStyle: .alert)
                    let okAction2 = UIAlertAction(title: "OK", style: .default) { action in
                        debugPrint(action)
                        //_ = self.navigationController?.popViewController(animated: true)
                    }
                    
                    alert2.addAction(okAction2)
                    self.present(alert2, animated: true, completion: nil)
                }
                
                
            }
        })
        task.resume()
    }
    
    @objc func addLabel(){
        AllLabelsField.text = AllLabelsField.text! + "," + LabelField.text!
        LabelField.text = "";
    }
    
    @objc func selectCoord(){
        self.performSegue(withIdentifier: "selectCoords", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let goNext = segue.destination as! SelectCoordsMapViewController
        goNext.delegate = self
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
