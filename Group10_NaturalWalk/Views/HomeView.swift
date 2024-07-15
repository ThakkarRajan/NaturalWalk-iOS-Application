//
//  HomeView.swift
//  Group7_NaturalWalk
//
//  Created by Rajan Vireshbhai Thakkar on 2024-07-11.
//

import SwiftUI

struct HomeView: View {
  
            @EnvironmentObject var appState: AppState
            @EnvironmentObject var fireAuthHelper : FireAuthHelper
            @EnvironmentObject var firedbHelper : FireDBHelper
//            let session: Session
            @State private var isSignOut = false
            var body: some View {
                NavigationView {
                
                    List( self.firedbHelper.sessionList ) { activity in
                        
                        NavigationLink(destination: ActivityDetailFirebase( activity: activity ).environmentObject(self.appState).environmentObject(self.fireAuthHelper).environmentObject(self.firedbHelper)) {
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
                    }.onAppear{
                        if appState.isLoggedIn {
                            self.firedbHelper.getAllUserList()
                            self.firedbHelper.getAllFavSession()
                            self.firedbHelper.getAllPurchaseList()
                        }
                    }
                    .navigationBarTitle("Activities")
                    
                    .toolbar {
                        if appState.isLoggedIn {
                            // Assuming isLoggedIn is a boolean property in AppState
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    appState.logout()
                                    self.fireAuthHelper.signOut()
                                    isSignOut = true
                                }) {
                                    Text("Logout")
                                        .foregroundColor(.red)
                                }
                                NavigationLink(destination: MainScreen(), isActive: $isSignOut) {
                                }
                            }
                            
                            
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    NavigationLink(destination: ProfileView().environmentObject(firedbHelper).environmentObject(fireAuthHelper).environmentObject(appState)) {
                                        Image(systemName: "person.circle")
                                            .font(.title)
                                    }
                                }
                            }
                            
                        }
                    .navigationBarBackButtonHidden(true)
                    }
                }
            } 


