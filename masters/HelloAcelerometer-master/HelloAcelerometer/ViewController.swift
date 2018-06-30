//
//  ViewController.swift
//  HelloAcelerometer
//
//  Created by Luis Ezcurdia on 5/1/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var avgX: UITextField!
    @IBOutlet weak var avgY: UITextField!
    @IBOutlet weak var avgZ: UITextField!

    @IBOutlet weak var maxX: UITextField!
    @IBOutlet weak var maxY: UITextField!
    @IBOutlet weak var maxZ: UITextField!

    @IBOutlet weak var minX: UITextField!
    @IBOutlet weak var minY: UITextField!
    @IBOutlet weak var minZ: UITextField!

    //let calcX = CentralTendencyCalculator()
    let motion = CMMotionManager()
    let frequency = 1.0 / 60.0  // 60 Hz
    var timer: Timer!
    
    let calculatorX = CentralTendencyCalculator()
    let calculatorY = CentralTendencyCalculator()
    let calculatorZ = CentralTendencyCalculator()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.motion.accelerometerUpdateInterval = frequency
        startAccelerometers()
    }

    func startAccelerometers() {
        guard self.motion.isAccelerometerAvailable else {
            print("No Acelerometer 😢")
            return
        }
        self.motion.startAccelerometerUpdates()

        let precision = 1000.0

        // Configure a timer to fetch the data.
        self.timer = Timer(fire: Date(), interval: frequency,
                           repeats: true, block: { (_) in
                            // Get the accelerometer data.
                            if let data = self.motion.accelerometerData {
                                let x = round(data.acceleration.x * precision) / precision
                                let y = round(data.acceleration.y * precision) / precision
                                let z = round(data.acceleration.z * precision) / precision

                                self.calculatorX.append(x)
                                self.calculatorY.append(y)
                                self.calculatorZ.append(z)
                                
                                self.avgX.text = String(self.calculatorX.avg())
                                self.avgY.text = String(self.calculatorY.avg())
                                self.avgZ.text = String(self.calculatorZ.avg())
                                
                                self.maxX.text = String(self.calculatorX.max)
                                self.maxY.text = String(self.calculatorY.max)
                                self.maxZ.text = String(self.calculatorZ.max)
                                
                                self.minX.text = String(self.calculatorX.min)
                                self.minY.text = String(self.calculatorY.min)
                                self.minZ.text = String(self.calculatorZ.min)
                
                            }
            })

        RunLoop.current.add(self.timer!, forMode: .defaultRunLoopMode)
    }

}
