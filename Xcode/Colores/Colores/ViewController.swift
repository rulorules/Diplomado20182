//
//  ViewController.swift
//  Colores
//
//  Created by d182_raul_j on 03/03/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit
let color_azul_claro = UIColor(named: "Azul-claro")!
let color_azul_fuerte = UIColor(named: "Azul-oscuro")!
let color_azul_verde = UIColor(named: "Azul-verde")!
let color_negro = UIColor(named: "Negro")!
let color_blanco = UIColor(named: "Blanco")!

let colorsUI = [UIColor(named: "Blanco")!, UIColor(named: "Negro")!]
class ViewController: UIViewController {

    let colors = ["Azul-claro", "Azul-oscuro","Azul-verde","Negro","Blanco"]
    var randomizedColors = [String]()
    
    //@IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var funButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionButton(_ sender: UIButton) {
        print("hola")
        self.view.backgroundColor = colorsUI[0]
        titleText.backgroundColor = color_blanco
        titleText.textColor = color_negro
        infoText.backgroundColor = color_azul_fuerte
        infoText.textColor = color_azul_fuerte
    }
    
    
    
}

