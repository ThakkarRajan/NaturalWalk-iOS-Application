//
//  PurchaseTicket.swift
//  Group7_NaturalWalk
//
//  Created by Rajan Vireshbhai Thakkar on 2024-07-11.
//


import Foundation

import FirebaseFirestore

class PurchaseTicket: Codable,  Identifiable  {
    @DocumentID
    var id : String? 
    var name: String
    var description: String
    var price: Double
    var numberOfTickets : Int
    var total : Double
    var tax : Double
    var rating: Int
    var host: String
    var photos: [String]
    var mobileNumber: Int?
    var isFavorite : Bool
    var parkLocation : String

    init(name: String, description: String, rating: Int, host: String, price: Double, photos: [String], mobileNumber: Int, isFavorite:Bool, parkLocation : String, numberOfTickets : Int , total : Double, tax :Double) {
        
        self.name = name
        self.description = description
        self.rating = rating
        self.host = host
        self.price = price
        self.photos = photos
        self.mobileNumber = mobileNumber
        self.isFavorite = isFavorite
        self.parkLocation = parkLocation
        self.total = total
        self.numberOfTickets = numberOfTickets
        self.tax = tax
    }
}

