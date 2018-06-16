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

class MapViewController: UIViewController {
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    
    let initialLocation = CLLocation(latitude: 19.433248,longitude: -101.9329)
    let regionRadius: CLLocationDistance = 3300000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.delegate = self
        //locationManager.delegate = self
        //enableBasicLocationServices()
        centerMapOnLocation(location: initialLocation)
        addLocations()
        // Do any additional setup after loading the view.
    }
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func addLocations(){
        let yodaBar = BarAnnotation(title: "Ciudad universitaria", locationName: "Ingeniería", discipline: "Star Wars", coordinate: CLLocationCoordinate2D(latitude: 19.325925, longitude: -99.182669))
        mapView.addAnnotation(yodaBar)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
