////
////  HomeScreen.swift
////  Group7_NaturalWalk
////
////  Created by Aaftab on 13/06/2024.
////
//
//import SwiftUI
//
//struct HomeScreen: View {
//    @State private var activity  = SessionsViewModel()
//    @EnvironmentObject var appState: AppState
//    
//    @EnvironmentObject var fireAuthHelper : FireAuthHelper
//    @EnvironmentObject var firedbHelper : FireDBHelper
//    
//    
//    var body: some View {
//        NavigationView {
//            List(activity.activity) { activity in
//                NavigationLink(destination: ActivityDetailsScreen(activity: activity).environmentObject(self.appState).environmentObject(self.fireAuthHelper).environmentObject(self.firedbHelper)) {
//                    HStack {
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack(spacing: 10) {
//                                ForEach(activity.photos, id: \.self) { photo in
//                                    Image(photo)
//                                        .resizable()
//                                        .frame(width: 80, height: 80)
//                                        .clipped()
//                                        .cornerRadius(8)
//                                }
//                            }
//                        }
//                        .frame(width: 80)
//                        
//                        VStack(alignment: .leading) {
//                            Text(activity.name)
//                                .font(.headline)
//                            Text("Price: $\(activity.price, specifier: "%.2f") per person")
//                                .font(.subheadline)
//                        }
//                        .padding(.leading, 8)
//                    }
//                }
//            }.onAppear{
//                self.firedbHelper.getAllFavSession()
//                
//                
////                              favHeartOn()
//                
//            }
//            .navigationBarTitle("Activities")
//            
//            .toolbar {
//                if appState.isLoggedIn {
//                    // Assuming isLoggedIn is a boolean property in AppState
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button(action: {
//                            appState.logout()
//                        }) {
//                            Text("Logout")
//                                .foregroundColor(.red)
//                        }
//                    }
//                }
//            }
//        }
//    } // body close
//    func favHeartOn(){
//        if appState.currentUser != nil {
//            if(appState.currentUser!.favorites.isEmpty)
//            {
//                for j in activity.activity{
//                    j.isFavorite = false
//                }
//            }
//            else{
//                for i in appState.currentUser!.favorites
//                {   for j in activity.activity{
//                    if j.name == i.name{
//                        if (i.isFavorite == true){
//                            j.isFavorite = true
//                        }else{
//                            j.isFavorite = false
//                        }
//                    }
//                }
//                }
//            }
//        }
//    }
//   
//}
