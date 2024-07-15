//
//  WishlistScreen.swift
//  Group7_NaturalWalk
//
//  Created by Aaftab on 13/06/2024.
//

import SwiftUI

struct WishlistScreen: View {
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var firedbHelper : FireDBHelper
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.firedbHelper.favoriteList, id: \.id) { activity in
                    
                    NavigationLink(destination: ActivityDetailFirebase(activity: activity)
                        .environmentObject(self.appState)
                        .environmentObject(self.fireAuthHelper)
                        .environmentObject(self.firedbHelper)) {
                            HStack {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        Image(activity.photos[0])
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .clipped()
                                            .cornerRadius(8)
                                    }
                                }
                                .frame(width: 80)
                                
                                VStack(alignment: .leading) {
                                    Text(activity.name)
                                        .font(.headline)
                                    Text("Price: $\(activity.price, specifier: "%.2f") per person")
                                        .font(.subheadline)
                                }
                                .padding(.leading, 8)
                            }
                        }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        print(#function, "Favorite to delete: ")
                        let deleteFavoriteList = self.firedbHelper.favoriteList[index]
                        self.firedbHelper.deleteFav(parkingDelete: deleteFavoriteList)
                    }
                })
            }
            .onAppear{
                self.firedbHelper.getAllFavSession()
            }
            .navigationBarTitle("Wishlist")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        deleteAllFavorites()
                    }) {
                        Text("Delete All")
                            .foregroundColor(.red)
                    }
                    
                }
                
                if appState.isLoggedIn {
                    // Assuming isLoggedIn is a boolean property in AppState
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            appState.logout()
                        }) {
                            Text("Logout")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
    } // body close
    
    private func deleteAllFavorites() {
        for favorite in self.firedbHelper.favoriteList {
            self.firedbHelper.deleteFav(parkingDelete: favorite)
        }
    }
}
