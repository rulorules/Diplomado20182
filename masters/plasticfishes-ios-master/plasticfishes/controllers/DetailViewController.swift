//
//  DetailViewController.swift
//  plasticfishes
//
//  Created by Luis Ezcurdia on 8/26/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    @IBOutlet weak var image: UIImageView?
    @IBOutlet weak var nameLbl: UILabel?
    @IBOutlet weak var textLbl: UILabel?
    
    var fish : Fish? {
        didSet { loadFish() }
    };

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFish()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadFish() {
        guard let current = self.fish else { return }
        self.title = current.name
        nameLbl?.text = current.name
        textLbl?.text = current.text
        guard let url = URL(string: current.imageUrl) else { return }
        image?.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "empty-pool"))
    }
}

