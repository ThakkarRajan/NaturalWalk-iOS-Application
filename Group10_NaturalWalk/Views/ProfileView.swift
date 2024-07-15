//
//  SwiftUIView.swift
//  Group7_NaturalWalk
//
//  Created by Rajan Vireshbhai Thakkar on 2024-07-11.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var fireAuthHelper: FireAuthHelper
    @EnvironmentObject var firedbHelper: FireDBHelper
    
    @State private var name = ""
    @State private var email = ""
    @State private var phNumber = ""
    @State private var address = ""
    @State private var isSignOut = false
    
    var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Group {
                    HStack {
                        Text("Name")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        Spacer()
                        
                        Text(name)
                            .textInputAutocapitalization(.words)
                            .padding(.trailing)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("E-Mail ID")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        Spacer()
                        
                        Text(email)
                            .autocapitalization(.none)
                            .padding(.trailing)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Phone No")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        Spacer()
                        
                        Text(phNumber)
                            .padding(.trailing)
                    }
                    Divider()
                    
                    HStack {
                        Text("Address ")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        Spacer()
                        
                        Text(address)
                            .padding(.trailing)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)                
                Spacer()
    
            }
            .disableAutocorrection(true)
            .onAppear {
                // Load the existing data onto form
                if let user = self.firedbHelper.userList.first {
                    self.name = user.name
                    self.email = user.email
                    self.phNumber = user.phoneNumber
                    self.address = user.address
                }
            }
            .navigationTitle("Profile View")
            .toolbar {
                if appState.isLoggedIn {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            appState.logout()
                            self.fireAuthHelper.signOut()
                            isSignOut = true
                        }) {
                            Text("Logout")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        } //body end
}
    
