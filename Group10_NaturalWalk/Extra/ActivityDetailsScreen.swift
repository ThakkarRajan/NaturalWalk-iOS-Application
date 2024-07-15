////
////  ActivityDetailsScreen.swift
////  Group7_NaturalWalk
////
////  Created by Aaftab on 13/06/2024.
////
//
//import SwiftUI
//
//struct ActivityDetailsScreen: View {
//    @ObservedObject var activity : Activity
//    @State private var isLogin = false
//    
//    
//    //@ObservedObject var activity1: Session
//    @EnvironmentObject var appState: AppState
//    @EnvironmentObject var firedbHelper : FireDBHelper
//    
//    @EnvironmentObject var fireAuthHelper : FireDBHelper
//    
//    var body: some View {
//        
//        ScrollView {
//            
//                VStack(alignment: .leading, spacing: 20) {
//                    Text(activity.name)
//                        .font(.title)
//                        .bold()
//                    
//                    Text(activity.description)
//                        .font(.body)
//                    
//                    HStack {
//                        Text("Rating: \(String(repeating: "★", count: activity.rating ))")
//                        Spacer()
//                        Text("Guide: \(activity.host)")
//                    }
//                    .font(.subheadline)
//                    
//                    TabView {
//                        ForEach (activity.photos, id: \.self){ photo in
//                            Image(photo)
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                        }
//                    }
//                    .frame(height: 300)
//                    .tabViewStyle(PageTabViewStyle())
//                    .cornerRadius(15)
//                    
//                    HStack {
//                        Text("Price: $\(activity.price, specifier: "%.2f") per person")
//                        Spacer()
//                        
//                        Button(action: {
//                            isLogin = false
//                            print("app state ", appState.isLoggedIn)
//                            if self.appState.isLoggedIn {
//                                toggleFavorite()
//                                isLogin = false
//                            }else{
//                                toggleFavorite()
//                                isLogin = true
//                            }
//                        }) {
//                            
//                            Image(systemName: activity.isFavorite ? "heart.fill" : "heart")
//                                .foregroundColor(.red)
//                        }
//                        .background(
//                            NavigationLink(destination: SignIn(appState: appState).environmentObject(self.fireAuthHelper).environmentObject(self.firedbHelper), isActive: $isLogin) {
//                                
//                               
//                            }
//                        )
//                        
//                        
//                        Button(action: shareSession) {
//                            Image(systemName: "square.and.arrow.up")
//                        }
//                    }
//                    .font(.subheadline)
//                    
//                    Button(action: callGuide) {
//                        Text("Call \(activity.host)")
//                    }
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//                
//                }
//                .padding()
//            }
//            .navigationBarTitle(activity.name, displayMode: .inline)
//        
//    } //body close //body close
//    
//    func callGuide() {
//        // Open phone dialer with guide's phone number
//        guard let phoneNumber = activity.mobileNumber else {
//            return
//        }
//        
//        guard let url = URL(string: "tel://\(phoneNumber)") else {
//            return
//        }
//        
//        if UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url)
//            
//        }}
//    
//    func shareSession() {
//        //Open share sheet to share session name and price
//        let activityItems: [Any] = [
//            "\(activity.name) - $\(activity.price) per person"
//        ]
//        
//        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
//        
//        if let viewController = UIApplication.shared.windows.first?.rootViewController {
//            viewController.present(activityViewController, animated: true, completion: nil)
//        }
//    }
//    
//    func toggleFavorite() {
//        
//        
//        guard let user = appState.currentUser else {
//            appState.isLoggedIn = false
//            self.isLogin = true
//            self.appState.isLoggedInFav = true
//            self.appState.isLoggedInFavName = self.activity.name
//            self.appState.isLoggedInFavPrice = self.activity.price
//            let newSession = Session(name: activity.name, description: activity.description, rating: activity.rating, host: activity.host, price: activity.price, photos: activity.photos, mobileNumber: activity.mobileNumber ??  0, isFavorite: activity.isFavorite)
//            self.appState.isLoggedInFavSession = newSession
//            return
//        }
//        
//        activity.isFavorite.toggle()
//        
//        if !activity.isFavorite {
//            user.favorites.removeAll{$0.name == activity.name}
//        } else {
//            
////            firedbHelper.fetchUserIDs(name: activity.name) { fetchedIDs in
////                   if let firstID = fetchedIDs.first {
////                       // Check if a favorite with the same name already exists
////                       
////                       if !firedbHelper.favoriteList.contains(where: { $0.name == activity.name }) {
////                           // If it doesn't exist, add it
////                           
////                           print("Added new favorite: \(activity.name)")
////                           self.firedbHelper.insertFavoriteSession(favorite: Favorite(name: activity.name, price: activity.price, id: firstID))
////                       } else {
////                           print("Favorite already exists: \(activity.name)")
////                       }
////                       print("Associated ID: ", firstID)
////                   } else {
////                       print("No IDs fetched")
////                   }
////                   print("SESSION DOC ID : ", fetchedIDs)
////               }
//               
//        }
//    }
//    
//}
//
