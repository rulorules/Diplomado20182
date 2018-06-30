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
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textFieldConsulta: UITextField!
    
    let initialLocation = CLLocation(latitude: 19.433248,longitude: -101.9329)
    let regionRadius: CLLocationDistance = 3300000
    
    @IBAction func textFieldPrimaryActionTriggered(_ sender: Any) {
        print(textFieldConsulta.text!)
        
        //Aqui hacer la peticion web
        
        let loginString = String(format: "%@:%@", "MANT\\indmantb", "Indep#17!")
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString3 = loginData.base64EncodedString()
        
        var components = URLComponents()
        components.scheme = "https"
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
        textFieldConsulta.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        //locationManager.delegate = self
        //enableBasicLocationServices()
        centerMapOnLocation(location: initialLocation)
        
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
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        print("le diste clic")
        let location = view.annotation as! BarAnnotation
        print(location.title!)
        print(location.recid)
        //let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        //location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}



