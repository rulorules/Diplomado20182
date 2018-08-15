//
//  Bars.swift
//  HelloCoreLocation
//
//  Created by d182_raul_j on 25/05/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import Foundation
import MapKit
import Contacts
class BarAnnotation: NSObject,MKAnnotation {
    let title: String?
    //let locationName: String?
    let recid: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, recid: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        //self.locationName = locationName
        self.recid = recid
        self.coordinate = coordinate
        super.init()
    }
    
//    var subtitle: String?{
//        return locationName
//    }
    
    func mapItem() -> MKMapItem {
        //let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
    
        return mapItem
    }
}
