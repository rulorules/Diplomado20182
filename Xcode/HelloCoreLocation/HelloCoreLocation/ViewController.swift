//
//  ViewController.swift
//  HelloCoreLocation
//
//  Created by d182_raul_j on 25/05/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    let locationManager = CLLocationManager()
    
    @IBOutlet var mapView: MKMapView!
    
    let initialLocation = CLLocation(latitude: 19.325925,longitude: -99.182669)
    let regionRadius: CLLocationDistance = 5000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        enableBasicLocationServices()
        centerMapOnLocation(location: initialLocation)
        addLocations()
    }
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addLocations(){
        let yodaBar = BarAnnotation(title: "ILM", recid: "ILM visitor", coordinate: CLLocationCoordinate2D(latitude: 19.325925, longitude: -99.182669))
        mapView.addAnnotation(yodaBar)
    }
}

extension ViewController: MKMapViewDelegate{
    
}

extension ViewController: CLLocationManagerDelegate{
    
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
        print("ALTL: \(lastLocation.altitude)")
        print("Lati: \(lastLocation.coordinate.latitude)")
        print("Long: \(lastLocation.coordinate.longitude)")
        // Do something with the location.
    }

}



