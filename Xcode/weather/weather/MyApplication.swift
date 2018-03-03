//
//  MyApplication.swift
//  weather
//
//  Created by d182_raul_j on 03/03/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit

class MyApplication: UIApplication{
    override func sendEvent(_ event: UIEvent){
        print("hola")
        super.sendEvent(event)
    }
}
