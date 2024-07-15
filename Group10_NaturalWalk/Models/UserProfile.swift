//
//  UserProfile.swift
//  Group7_NaturalWalk
//
//  Created by Rajan Vireshbhai Thakkar on 2024-07-11.
//

import SwiftUI

    struct UserProfile: Codable, Identifiable {
        var id: String? 
        var email: String
        var name: String
        var phoneNumber: String
        var address: String
    }


