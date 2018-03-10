//
//  ViewController.swift
//  segueProgramatic
//
//  Created by d182_raul_j on 09/03/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var segueSwitch: UISwitch!
    @IBOutlet weak var segueSwitch2: UISwitch!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func yellowButtonTapped(_ sender: Any) {
        if segueSwitch.isOn{
            performSegue(withIdentifier: "yellow", sender: nil)
        }
        
    }
    
    
    @IBAction func purpleButtonTapped(_ sender: Any) {
        if segueSwitch.isOn{
            performSegue(withIdentifier: "purple", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
     @IBAction func hideKeyboard(_ sender: Any){
        textField.resignFirstResponder()
     }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        return textField.resignFirstResponder()
    }
    
}

