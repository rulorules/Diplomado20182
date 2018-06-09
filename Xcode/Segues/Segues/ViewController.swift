//
//  ViewController.swift
//  Segues
//
//  Created by d182_raul_j on 09/03/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindToRed(_ unwindSegue: UIStoryboardSegue){
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue.destination.navigationItem.title = textField.text
    }
}

