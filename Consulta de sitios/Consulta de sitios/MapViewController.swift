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
        let cadena:String = "111,Ciudad uni,19.325925,-99.182669,222,Anexo,19.425925,-99.282669,333,Las islas,19.225925,-99.082669"
        let cadena_sep = cadena.components(separatedBy: ",")
        
        let sequence = stride(from: 0, to: cadena_sep.count, by: 4)
        
        for element in sequence {
            addLocations(title: String(cadena_sep[element+1]), recid: cadena_sep[element], latitude: Double(cadena_sep[element+2])!, longitude: Double(cadena_sep[element+3])!)
        }
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



