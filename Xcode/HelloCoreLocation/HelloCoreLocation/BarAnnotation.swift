//
//  Bars.swift
//  HelloCoreLocation
//
//  Created by d182_raul_j on 25/05/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import Foundation
import MapKit

class BarAnnotation: NSObject,MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        super.init()
    }
    
    var subtitle: String?{
        return locationName
    }
}
