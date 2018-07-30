//
//  SelectCoordsMapViewController.swift
//  Consulta de sitios
//
//  Created by Jorge Alba on 26/07/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
protocol ChildViewControllerDelegate
{
    func childViewControllerResponse(type: [String])
}

class SelectCoordsMapViewController: UIViewController {

    //Objeto para mi localización
    let locationManager = CLLocationManager()
    let initialLocation = CLLocation(latitude: 19.433248,longitude: -101.9329)
    let regionRadius: CLLocationDistance = 3300000
    var delegate: ChildViewControllerDelegate?
    var selectedLatitude = 0.0
    var selectedLongitude = 0.0
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        mapView.showsUserLocation=true
        enableBasicLocationServices()
        let buttonItem = MKUserTrackingBarButtonItem(mapView: mapView)
        self.navigationItem.rightBarButtonItem = buttonItem
        
        let uilgr = UILongPressGestureRecognizer(target: self, action: #selector(action))
        uilgr.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(uilgr)
        
        // Do any additional setup after loading the view.
    }

    @objc func action(gestureRecognizer:UIGestureRecognizer){
        
        let touchPoint = gestureRecognizer.location(in: mapView)
        let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinates
        mapView.addAnnotation(annotation)
        selectedLatitude = annotation.coordinate.latitude
        selectedLongitude = annotation.coordinate.longitude
        
        let coord = [String(selectedLatitude),String(selectedLongitude)]
        //self.delegate?.childViewControllerResponse(controller: SelectCoordsMapViewController)
        delegate?.childViewControllerResponse(type: coord)
        //self.addLocations(title: String("Mi casa"), recid: "123", latitude: 19.485680235508067, longitude: -99.134074609823102)
        //sleep(1)
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addLocations(title: String, recid: String, latitude: Double, longitude: Double){
        let yodaBar = BarAnnotation(title: title, recid: recid, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        mapView.addAnnotation(yodaBar)
        
    }
    
}

extension SelectCoordsMapViewController: MKMapViewDelegate {
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
    
    
    func mapViewWillStartLocatingUser(_ mapView: MKMapView){
        
    }
    
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool){
        
        if(mode == MKUserTrackingMode.follow){
            print("que onda")
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    }
    
    
}


extension SelectCoordsMapViewController: CLLocationManagerDelegate{
    
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
        //guard let lastLocation = locations.last else {return}
        //let zoomToMapPoint = MKMapPointForCoordinate((lastLocation.coordinate))  // we know we have a coordinate, so we can use force unwrapping here
        //let zoomToMapSize = MKMapSize(width: 1000, height: 1000)  // set a rectangle around the user's location
        //let zoomToMapRect = MKMapRect(origin: zoomToMapPoint, size: zoomToMapSize)
        //mapView.setVisibleMapRect(zoomToMapRect, animated: true)
    }
}
