//
//  Group7_NaturalWalkApp.swift
//  Group7_NaturalWalk
//
//  Created by Aaftab on 13/06/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

@main
struct Group7NatureWalkApp: App {

    @StateObject var appState = AppState()

    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainScreen().environmentObject(appState)
        }
    }
}
