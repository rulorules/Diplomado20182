//
//  MapViewController.swift
//  Consulta de sitios
//
//  Created by d182_raul_j on 16/06/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,UITextFieldDelegate {
    
    //Objeto para mi localización
    let locationManager = CLLocationManager()
    let initialLocation = CLLocation(latitude: 19.433248,longitude: -101.9329)
    let regionRadius: CLLocationDistance = 3300000
    
    var username:String = ""
    var password:String = ""

    //Vista de información del sitio
    let bottomSheetVC = BottomSheetViewController()
    //Etiqueta que va sobre la vista de la información
    let textView: UILabel = {
        let tf = UILabel()
        tf.textColor = UIColor.white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textFieldConsulta: UITextField!
    
    //Oculta el teclado
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textFieldConsulta.resignFirstResponder()
    }
    
    //Acción que se realiza al presionar el nombre del sitio
    @IBAction func textFieldPrimaryActionTriggered(_ sender: Any) {
        print(textFieldConsulta.text!)
        
        //Petición web
        //let loginString = String(format: "%@:%@", "ARREN\\"+username, password)
        let loginString = String(format: "%@:%@", "MANT\\"+username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString3 = loginData.base64EncodedString()
        
        var components = URLComponents()
        components.scheme = "https"
        //components.host = "apptelesitesprodu.azurewebsites.net"
        components.host = "apptelesitesprodu.azurewebsites.net"
        components.path = "/coordsname/"+textFieldConsulta.text!
        
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
                
                DispatchQueue.main.async {
                    //self.performSegue(withIdentifier: "Opciones", sender: nil)
                    self.mapView.removeAnnotations(self.mapView.annotations)
                    
                    var cadena_sep = resultado!.components(separatedBy: "|")
                    
                    cadena_sep[0].remove(at: cadena_sep[0].startIndex)
                    let sequence = stride(from: 0, to: cadena_sep.count - 1, by: 4)
                    for element in sequence {
                        self.addLocations(title: String(cadena_sep[element+2]), recid: cadena_sep[element+3], latitude: Double(cadena_sep[element])!, longitude: Double(cadena_sep[element+1])!)
                        
                    }
                }
                
                
            } else {
                print("Unsuccesful request: \(resp)")
                //self.performSegue(withIdentifier: "Opciones", sender: nil)
            }
        })
        task.resume()
        //Oculta el teclado
        textFieldConsulta.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        //locationManager.delegate = self
        //enableBasicLocationServices()
        centerMapOnLocation(location: initialLocation)
        mapView.showsUserLocation=true
        enableBasicLocationServices()
        let buttonItem = MKUserTrackingBarButtonItem(mapView: mapView)
        self.navigationItem.rightBarButtonItem = buttonItem
        addBottomSheetView()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationOnLongPress(gesture:)))
        longPressGesture.minimumPressDuration = 1.0
        self.mapView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func addAnnotationOnLongPress(gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .ended {
            let point = gesture.location(in: self.mapView)
            let coordinate = self.mapView.convert(point, toCoordinateFrom: self.mapView)
            //print(coordinate)
            //Now use this coordinate to add annotation on map.
            var annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            //Set title and subtitle if you want
            annotation.title = ""
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotation(annotation)
            
            //let loginString = String(format: "%@:%@", "MANT\\"+username, password)
            let loginString = String(format: "%@:%@", "MANT\\"+username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString3 = loginData.base64EncodedString()
            
            var components = URLComponents()
            components.scheme = "https"
            components.host = "apptelesitesprodu.azurewebsites.net"
            //components.host = "apptelesitestest.azurewebsites.net"
            //components.path = "/getArt/"+textFieldConsulta.text!
            components.path = "/coords/"+String(coordinate.latitude)+","+String(coordinate.longitude)+"/"
            
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
                    
                    DispatchQueue.main.async {
                        //self.performSegue(withIdentifier: "Opciones", sender: nil)
                        self.mapView.removeAnnotations(self.mapView.annotations)
                        
                        var cadena_sep = resultado!.components(separatedBy: "|")
                        
                        cadena_sep[0].remove(at: cadena_sep[0].startIndex)
                        let sequence = stride(from: 0, to: cadena_sep.count - 1, by: 4)
                        for element in sequence {
                            self.addLocations(title: String(cadena_sep[element+2]), recid: cadena_sep[element+3], latitude: Double(cadena_sep[element])!, longitude: Double(cadena_sep[element+1])!)
                            
                        }
                        
                    }
                    
                    
                } else {
                    print("Unsuccesful request: \(resp)")
                    //self.performSegue(withIdentifier: "Opciones", sender: nil)
                }
            })
            task.resume()
        }
    }
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func addLocations(title: String, recid: String, latitude: Double, longitude: Double){
        let yodaBar = BarAnnotation(title: title, recid: recid, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        mapView.addAnnotation(yodaBar)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let closeButton: UIButton = { //Closure
        let btn = UIButton(type: .system)
        //btn.backgroundColor = UIColor(red: 195/255, green: 1/255, blue: 1/255, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setImage(UIImage(named:"cancel-icon.png"), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(closeWindow), for: .touchUpInside)
        return btn
    }()
    @objc func closeWindow(){
        let height = view.frame.height
        let width  = view.frame.width
        //bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        bottomSheetVC.viewDidAppear(true)
        UIView.animate(withDuration: 1, animations: {
            self.bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        })
    }
    
    func addBottomSheetView() {
        // 1- Init bottomSheetVC
        bottomSheetVC.view.addSubview(closeButton)
        
        /**Boton de registro******/
        closeButton.rightAnchor.constraint(equalTo: bottomSheetVC.view.rightAnchor, constant: -20).isActive = true
        closeButton.topAnchor.constraint(equalTo: bottomSheetVC.view.topAnchor, constant: 20).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        /*************************/
        
        // 2- Add bottomSheetVC as a child view
        self.addChildViewController(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParentViewController: self)
        
        // 3- Adjust bottomSheet frame and initial position.
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
        //textView.text = "hola, esto es un texto sumamente my muy super \nlarguisimo a ver que parece verse"
        textView.backgroundColor = UIColor.clear
        bottomSheetVC.view.addSubview(textView)
        
        textView.leftAnchor.constraint(equalTo: bottomSheetVC.view.leftAnchor, constant: 30).isActive = true
        textView.topAnchor.constraint(equalTo: bottomSheetVC.view.topAnchor, constant: 30).isActive = true
        //textView.bottomAnchor.constraint(equalTo: bottomSheetVC.view.bottomAnchor, constant: 30).isActive = true
        textView.rightAnchor.constraint(equalTo: bottomSheetVC.view.rightAnchor).isActive = true
        textView.lineBreakMode = .byWordWrapping
        textView.numberOfLines = 20
        
    }
}


//Agrega ventana de informacón del pin
extension MapViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? BarAnnotation else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            //*****/
            view.markerTintColor = UIColor.clear
            let image = UIImage(named: "ioslab")!.withRenderingMode(.alwaysTemplate)
            view.glyphImage = image
            view.glyphTintColor = UIColor.orange
            /*****/
        }
        return view
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! BarAnnotation
        
        //Petición web
        //let loginString = String(format: "%@:%@", "MANT\\"+username, password)
        let loginString = String(format: "%@:%@", "MANT\\" + username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString3 = loginData.base64EncodedString()
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "apptelesitesprodu.azurewebsites.net"
        //components.host = "apptelesitestest.azurewebsites.net"
        //components.path = "/getArt/"+textFieldConsulta.text!
        components.path = "/siteinfo/"+location.recid
        
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
                
                DispatchQueue.main.async {
                    var cadena_sep = resultado!.components(separatedBy: "|")
                    
                    cadena_sep[0].remove(at: cadena_sep[0].startIndex)
                    
                    self.textView.text = "ID Sitio: " + cadena_sep[0] + "\n\nSitio: " + cadena_sep[1] + "\n\nTipo de acceso: " + cadena_sep[8] + "\n\nTipo de torre: " + cadena_sep[2] + "\n\nAltura de torre: " + cadena_sep[3] + "\n\nAltura del inmueble: " + cadena_sep[4] + "\n\nDirección: " + cadena_sep[5] + "\n\nArrendador: " + cadena_sep[6] + "\n\nRenta: " + cadena_sep[7]
                    UIView.animate(withDuration: 1, animations: {
                        let frame = self.view.frame
                        let yComponent = UIScreen.main.bounds.height - 400
                        self.bottomSheetVC.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height)
                    })
                    
                }
                
                
            } else {
                print("Unsuccesful request: \(resp)")
                //self.performSegue(withIdentifier: "Opciones", sender: nil)
            }
        })
        task.resume()
    }
    
    func mapViewWillStartLocatingUser(_ mapView: MKMapView){
        
    }
    
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool){
        
        if(mode == MKUserTrackingMode.follow){
                      //Petición web
            
            //let loginString = String(format: "%@:%@", "MANT\\"+username, password)
            let loginString = String(format: "%@:%@", "MANT\\" + username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString3 = loginData.base64EncodedString()
            
            var components = URLComponents()
            components.scheme = "https"
            components.host = "apptelesitesprodu.azurewebsites.net"
            //components.host = "apptelesitestest.azurewebsites.net"
            //components.path = "/getArt/"+textFieldConsulta.text!
            components.path = "/coords/"+String(locationManager.location!.coordinate.latitude)+","+String(locationManager.location!.coordinate.longitude)+"/"
            
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
                    
                    DispatchQueue.main.async {
                        //self.performSegue(withIdentifier: "Opciones", sender: nil)
                        self.mapView.removeAnnotations(self.mapView.annotations)
                        
                        var cadena_sep = resultado!.components(separatedBy: "|")
                        
                        cadena_sep[0].remove(at: cadena_sep[0].startIndex)
                        let sequence = stride(from: 0, to: cadena_sep.count - 1, by: 4)
                        for element in sequence {
                            self.addLocations(title: String(cadena_sep[element+2]), recid: cadena_sep[element+3], latitude: Double(cadena_sep[element])!, longitude: Double(cadena_sep[element+1])!)
                            
                        }

                    }
                    
                    
                } else {
                    print("Unsuccesful request: \(resp)")
                    //self.performSegue(withIdentifier: "Opciones", sender: nil)
                }
            })
            task.resume()
 
        }
    }
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //print("MapKit has found the user's location, and called the delegate method")
        
        //print("Lati: \(userLocation.location?.coordinate.latitude)")
        //print("Long: \(userLocation.location?.coordinate.longitude)")
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let coordinate = view.annotation?.coordinate {
            
            print("Latis: \(coordinate.latitude)")
            print("Long: \(coordinate.longitude)")
            
            
            let height = view.frame.height
            let width  = view.frame.width
            //bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
            bottomSheetVC.viewDidAppear(true)
            UIView.animate(withDuration: 1, animations: {
                self.bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
                })
            /*textView.text = "le atinaste"
             UIView.animate(withDuration: 1, animations: {
             let frame = self.view.frame
             let yComponent = UIScreen.main.bounds.height - 400
             self.bottomSheetVC.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height)
             })*/
            
        }
    }
}

extension MapViewController: CLLocationManagerDelegate{
    
    func enableBasicLocationServices() {
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            //enableMyWhenInUseFeatures()
            break
        case .restricted, .denied:
            // Disable location features
            disableMyLocationBasedFeatures()
            break
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            enableMyWhenInUseFeatures()
            break
        }
    }
    func disableMyLocationBasedFeatures(){
        print("disable location services...")
    }
    
    func enableMyWhenInUseFeatures(){
        print("enable location services...")
        guard checkForLocationServices() else {return}
        startReceivingLocationChanges()
        //stgartReciving
    }
    
    func checkForLocationServices() -> Bool{
        if CLLocationManager.locationServicesEnabled(){
            print("Location services are avaible, so query the users location.")
            return true
        } else {
            print("Update your apps UI to show that the location is unaviable")
            return false
        }
    }
    
    func startReceivingLocationChanges() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 100.0  // In meters.
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {return}
        let zoomToMapPoint = MKMapPointForCoordinate((lastLocation.coordinate))  // we know we have a coordinate, so we can use force unwrapping here
        let zoomToMapSize = MKMapSize(width: 10000, height: 10000)  // set a rectangle around the user's location
        _ = MKMapRect(origin: zoomToMapPoint, size: zoomToMapSize)
        //mapView.setVisibleMapRect(zoomToMapRect, animated: true)
        
        // Do something with the location.
}
}

