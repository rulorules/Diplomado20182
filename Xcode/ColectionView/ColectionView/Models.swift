//
//  Models.swift
//  ColectionView
//
//  Created by d182_raul_j on 21/04/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import Foundation

class Category: NSObject{
    var name: String?
    var albums: [Album]?
    
    static func samples() -> [Category]{
        let bestNewAlbums = Category()
        bestNewAlbums.name = "Los mejores"
        
        var albums = [Album]()
        let album = Album()
        album.category = "Rock"
        album.name = "Queen"
        album.image = "cover1"
        
        albums.append(album)
        
        bestNewAlbums.albums = albums
        
        let bestClassicAlbums = Category()
        bestNewAlbums.name = "Musica clásica"
        
        return[bestNewAlbums, bestClassicAlbums]
    }
}

class Album: NSObject {
    var name: String?
    var category: String?
    var image: String?
}
