//
//  Sessions.swift
//  Group7_NaturalWalk
//
//  Created by Darksun on 2024-07-07.
//

import Foundation
import FirebaseFirestore

struct Session : Hashable, Codable , Identifiable {
    
    @DocumentID
    var id : String? 
    var name: String
    var description: String
    var rating: Int
    var host: String
    var price: Double
    var photos: [String]
    var mobileNumber: Int?
    var isFavorite : Bool
    var parkLocation : String

    init(name: String, description: String, rating: Int, host: String, price: Double, photos: [String], mobileNumber: Int, isFavorite:Bool, parkLocation : String) {
        
        self.name = name
        self.description = description
        self.rating = rating
        self.host = host
        self.price = price
        self.photos = photos
        self.mobileNumber = mobileNumber
        self.isFavorite = isFavorite
        self.parkLocation = parkLocation
    }
}

