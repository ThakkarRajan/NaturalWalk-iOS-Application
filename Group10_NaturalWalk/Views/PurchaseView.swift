//
//  PuechaseView.swift
//  Group7_NaturalWalk
//
//  Created by Rajan Vireshbhai Thakkar on 2024-07-11.
//

import SwiftUI

struct PurchaseView: View {
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var fireAuthHelper: FireAuthHelper
    @EnvironmentObject var firedbHelper: FireDBHelper
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    if(self.firedbHelper.purchaseList.isEmpty){
                        VStack(alignment: .leading) {
                            
                                Text("Purchase List is Empty")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity  )
                            }
                        }
                    
                    
                        else{
                            ForEach(self.firedbHelper.purchaseList) { activity in
                                let sessionList = Session(name: activity.name, description: activity.description, rating: activity.rating, host: activity.host, price: activity.price, photos: activity.photos, mobileNumber: activity.mobileNumber!, isFavorite: activity.isFavorite, parkLocation: activity.parkLocation)
                                
                                NavigationLink(destination: ActivityDetailFirebase(activity: sessionList).environmentObject(self.appState).environmentObject(self.fireAuthHelper).environmentObject(self.firedbHelper)) {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(activity.name)
                                            .font(.title2)
                                            .bold()
                                            .foregroundColor(.primary)
                                        
                                        Text("Price: $\(activity.price, specifier: "%.2f")per person")
                                            .foregroundColor(.green)
                                            .bold()
                                            .font(.headline)
                                        
                                        HStack {
                                            Text("Total Tickets: \(activity.numberOfTickets)")
                                                .foregroundColor(.secondary)
                                            
                                            Spacer()
                                            
                                            Text("Host: \(activity.host)")
                                                .foregroundColor(.secondary)
                                        }
                                        .font(.subheadline)
                                        
                                        
                                        
                                        Text("Total Price: $\(activity.total, specifier: "%.2f")")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                    }
                                }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(UIColor.systemBackground))
                                            .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
                                    )
                                    .padding(.horizontal)
                                }
                            }
                }
                .padding()
                .onAppear {
                    self.firedbHelper.initializePurchaseList()
                    self.firedbHelper.getAllPurchaseList()
                }
                .navigationBarTitle("Your Purchases", displayMode: .inline)
                .toolbar {
                    if appState.isLoggedIn {
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
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

