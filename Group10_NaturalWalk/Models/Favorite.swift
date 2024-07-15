//
//  Favorite.swift
//  Group7NatureWalk
//
//  Created by Rajan Vireshbhai Thakkar on 2024-07-08.
//

import Foundation

struct Favorite : Codable {
    
    var name: String
    var price: Double
    var id : String
    

    init(name: String, price: Double, id : String) {
        self.name = name
        self.price = price
        self.id = id
     
    }
}

