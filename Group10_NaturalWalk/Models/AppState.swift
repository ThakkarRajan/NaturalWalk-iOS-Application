//
//  AppState.swift
//  Group7_NaturalWalk
//
//  Created by Aaftab on 13/06/2024.

import Foundation

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: appUser?
    @Published var isLoggedInFav: Bool = false
    @Published var isLoggedInFavName: String = ""
    @Published var isLoggedInFavSession  = Session(name: "", description: "", rating: 0, host: "", price: 0.0, photos: [""], mobileNumber:0, isFavorite: false, parkLocation: "")
    
    func logout() {
        currentUser = nil
        isLoggedIn = false
        isLoggedInFav = false
        isLoggedInFavName = ""
        
        objectWillChange.send()
    }
    
}
