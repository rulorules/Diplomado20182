//
//  ViewController.swift
//  animaniac
//
//  Created by d182_raul_j on 12/05/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var actionBtn1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //actionBtn1.bounds = CGRect(x: actionBtn1.center.x, y: actionBtn1.center.y, width: actionBtn1.bounds.width / 10.0, height: actionBtn1.bounds.height)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTapBtn1(_ sender: Any) {
        //let anima  = CAKeyframeAnimation(keyPath: "backgroundColor")
        let anima  = CASpringAnimation(keyPath: "transform.scale.x")
        
        anima.fromValue = 1
        anima.toValue = 2
        anima.damping = 4
        anima.duration = 2

//        let times: [NSNumber] = [0.0,0.25,0.5,0.75,1.0]
//        anima.keyTimes = times
//        anima.values = [UIColor.red.cgColor,UIColor.yellow.cgColor,UIColor.green.cgColor,UIColor.cyan.cgColor,UIColor.blue.cgColor]
//        anima.duration = 3
//        anima.repeatCount = 3
//        anima.autoreverses = true
        self.view.layer.add(anima, forKey: "transform.scale.x")
        
        
        //anima.timingFunctions(name: kCAMediaTimingFunctionEaseOut)
//        UIView.animate(withDuration: 1, animations: {
//            //self.actionBtn1.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//            //self.actionBtn1.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
//            //self.actionBtn1.backgroundColor = .green
//            self.actionBtn1.transform = CGAffineTransform(translationX: 100, y: 0)
//        }){(success) in
//            guard success else {return}
//            UIView.animate(withDuration: 0.3, animations: {
//                self.actionBtn1.transform = CGAffineTransform.identity
//                self.actionBtn1.backgroundColor = .purple
//            })
//
//        }
        
    }
    
}

