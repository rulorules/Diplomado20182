//
//  CentralTendencyCalculator.swift
//  HelloAcelerometer
//
//  Created by Luis Ezcurdia on 5/2/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import Foundation

class CentralTendencyCalculator {
    var total: Double = 0.0
    var count: UInt = 0
    var min: Double = 0.0
    var max: Double = 0.0
    
    func append(_ item: Double) {
        if count == 0{
            min = item
            max = item
        }else{
            if item < min {
                min = item
            }
            if item > max {
                max = item
            }
        }
        total += item
        count += 1
        
    }

    func avg() -> Double {
        
        return total / Double(count)
        
    }

//    var min: Double = {
//        return 0.0
//    }()
//
//    var max: Double = {
//        return 0.0
//    }()
}
