//
//  ViewController.swift
//  mytabs
//
//  Created by d182_raul_j on 16/03/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let unwrappedItems = self.tabBar.items else { return }
        for item in unwrappedItems {
            guard let unwrappedItemTitle = item.title else { continue }
            if unwrappedItemTitle == "Workshop"{
                item.badgeValue = "666"
            }
            if unwrappedItemTitle == "Second"{
                item.isEnabled = false
            }
            print(item.title!)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
