//
//  ViewController.swift
//  prueba
//
//  Created by markmota on 2/24/18.
//  Copyright © 2018 markmota. All rights reserved.
//  Fixed by Raúl Rodolfo Jiménez Saavedra

import UIKit

class ViewController: UIViewController {
    
    //Changed var outtletText to outletText and added @IBOutlet
    @IBOutlet weak var outletText: UILabel!
    @IBOutlet weak var aoutletButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        aoutletButton.setTitle("Touch me!", for: .normal)
        //Just to remove the "Label" Text y the label
        outletText.text = ""
    
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
    }

    //Added IBAction to the method and UIButton as a parameter
    @IBAction func actionButton(_ sender: UIButton) {
        outletText.text = "You are a genius "
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

