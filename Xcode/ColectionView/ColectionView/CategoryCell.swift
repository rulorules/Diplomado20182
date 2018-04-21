//
//  CategoryCell.swift
//  ColectionView
//
//  Created by d182_raul_j on 21/04/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let albumCellId = "albumCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let AlbumCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionview.backgroundColor = UIColor.white
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Rock"
        label.font = UIFont.systemFont(ofSize: 20)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var albumCategory: Category?{
        didSet{
            if let name = albumCategory?.name{
                categoryLabel.text = name
            }
        }
    }
    
    func setupLayout(){
        //backgroundColor = UIColor.red
        addSubview(AlbumCollectionView)
        addSubview(categoryLabel)
        AlbumCollectionView.dataSource = self
        AlbumCollectionView.delegate = self
        
        AlbumCollectionView.register(AlbumCell.self, forCellWithReuseIdentifier: albumCellId)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": categoryLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": AlbumCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v1][v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": AlbumCollectionView, "v1":categoryLabel]))
    }


     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        // #warning Incomplete implementation, return the number of items
        return 5
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumCellId, for: indexPath) as! AlbumCell
        
        // Configure the cell
        cell.backgroundColor = UIColor.white
        cell.album = albumCategory?.albums![indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayaut: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 180)
        
    }

    
}
