//
//  ViewController.swift
//  Switch
//
//  Created by d182_raul_j on 09/03/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchActivated(_
        sender: UISwitch){
            if(sender.isOn){
                    print("The switch is on!")
            }else{
                print("The switch is off!")
            }
        }
    
    @IBAction func sliderAction(_
        sender: UISlider){
        print(sender.value)
    }
    
    @IBAction func keyboardReturnKeyTapped(_
        sender:UITextField){
        if let text = sender.text{ //Optional binding
            print(text)
        }
    }
    
    
    
    
    
    }



