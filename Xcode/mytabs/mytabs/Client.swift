//
//  Client.swift
//  mytabs
//
//  Created by d182_raul_j on 16/03/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import Foundation

struct Client {
    let firstName: String?
    let lastName: String?
    let email: String?
    let gender: String?
    //let image = Image?
    
    var fullName: String {
        var out = ""
        if let fname = firstName{
            out += "\(fname) "
        }
        if let lname = lastName {
            out += lname
        }
        return out
    };
}
