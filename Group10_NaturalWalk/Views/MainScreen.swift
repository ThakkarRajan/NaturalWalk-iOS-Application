//
//  MainScreen.swift
//  Group7_NaturalWalk
//
//  Created by Rajan Vireshbhai Thakkar on 2024-07-08.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject var appState : AppState
    @StateObject var firedbHelper : FireDBHelper = FireDBHelper.getInstance()
    @StateObject var fireAuthHelper : FireAuthHelper = FireAuthHelper.getInstance()
    
    var body: some View {
        if appState.isLoggedIn {
            TabView {
                HomeView().environmentObject(self.appState).environmentObject(self.fireAuthHelper).environmentObject(self.firedbHelper)
                
                    .tabItem {
                        Label("Activities", systemImage: "list.dash")
                    }
                
                WishlistScreen().environmentObject(appState) .environmentObject(firedbHelper).environmentObject(fireAuthHelper)
                
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
                
                PurchaseView().environmentObject(appState) .environmentObject(firedbHelper).environmentObject(fireAuthHelper)
                
                    .tabItem {
                        Label("Purchased", systemImage: "purchased")
                    }
            }
            
            }
        else{
            HomeView().environmentObject(self.appState).environmentObject(self.fireAuthHelper).environmentObject(self.firedbHelper)
  
        }   
    }
}


