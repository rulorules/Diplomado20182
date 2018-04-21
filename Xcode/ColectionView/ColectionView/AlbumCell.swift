//
//  AlbumCell.swift
//  ColectionView
//
//  Created by d182_raul_j on 21/04/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell{
    
    var album: Album?{
        didSet{
            if let name = album?.name{
                titleLabel.text = name
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "cover1")
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Queen"
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 2
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "ROCK y ya"
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 2
        return label
    }()
    
    func setupLayout(){
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(categoryLabel)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        titleLabel.frame = CGRect(x: 0, y: frame.width, width: frame.width, height: 40)
        categoryLabel.frame = CGRect(x: 0, y: frame.width+40, width: frame.width, height: 40)
    }
    
    
}
