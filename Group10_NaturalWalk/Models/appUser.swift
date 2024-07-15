//
//  User.swift
//  Group7_NaturalWalk
//
//  Created by Aaftab on 13/06/2024.
//

import Foundation

class appUser: ObservableObject {
    @Published var email: String
    @Published var password: String
    
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
