//
//  ActivityDetailFirebase.swift
//  Group7_NaturalWalk
//
//  Created by Rajan Vireshbhai Thakkar on 2024-07-11.
//

import SwiftUI
import CoreLocation
import MapKit

struct ActivityDetailFirebase: View {
    
    var activity : Session
    @State private var isLogin = false
    @State private var showingLoginAlert = false
    @State private var numberOfTickets = 1
    @State private var latitude = 0.0
    @State private var longitude = 0.00
    @State private var showingPurchaseSheet = false
    @State private var showAlert = false
    @State private var isFav = false
    @State private var alertMessage = ""
    @State private var parkAdd = ""
    
    @EnvironmentObject var fireAuthHelper : FireDBHelper
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var firedbHelper : FireDBHelper

    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text(activity.name)
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                
                HStack {
                    Text("Rating: \(String(repeating: "★", count: activity.rating ))")
                        .foregroundColor(.yellow)
                        .bold()
                    
                    Spacer()
                    
                    Text("Host: \(activity.host)")
                        .foregroundColor(.blue)
                }
                .font(.subheadline)
                
                TabView {
                    ForEach(activity.photos, id: \.self) { photo in
                        Image(photo)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(15)
                    }
                }
                .frame(height: 300)
                .tabViewStyle(PageTabViewStyle())
                .cornerRadius(15)
                .padding(.vertical, 10)
                
                
                HStack {
                    Text("Price: $\(activity.price, specifier: "%.2f") per person")
                        .foregroundColor(.green)
                        .bold()
                        .font(.custom("", size: 18))
                    
                    Spacer()
                    
                    Button(action: callGuide) {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.blue)
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                    
                    Button(action: {
//                        isLogin = false
                        print("app state ", appState.isLoggedIn)
                        if self.appState.isLoggedIn {
                            isLogin = false
                            appState.isLoggedIn = true
                            self.toggleFavorite()
                            
                        }else{
                            self.toggleFavorite()
                            //showingLoginAlert = true
                        }
                    }) {
                        
                    Image(systemName: isFav ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red, lineWidth: 1)
                    )
                    .background(
                        NavigationLink(destination: SignIn(appState: appState).environmentObject(self.fireAuthHelper).environmentObject(self.firedbHelper), isActive: $isLogin) {
                        }
                    )
                   
                    .alert(isPresented: $showingLoginAlert) {
                        Alert(
                            title: Text("Login Required"),
                            message: Text("You need to be logged in to perform this action."),
                            primaryButton: .default(Text("Login")) {
                                self.isLogin = true
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    Button{
                       
                        self.openMapForPlace()
                    } label: {
                        
                        Image(systemName: "map")
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                    
                    Button(action: shareSession) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                }
                .font(.subheadline)
                
                Text(activity.description)
                    .font(.body)
                    .foregroundColor(.black)
                
                Button(action: {
                    initiateTicketPurchase()
                }) {
                    
                    Text("Purchase")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    
                }
                .padding(.horizontal)
                
                
            }
            .padding()
        }
        .onAppear{
            if appState.isLoggedIn{
                checkFavorite(withName: activity.name)
            }
            parkAdd = activity.parkLocation
            self.getLocationCoordinates()
            isLogin = false
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Result"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $showingPurchaseSheet) {
            VStack(alignment: .center, spacing: 20) {
                Text("Purchase Tickets for \(activity.name)")
                    .font(.headline)
                
                Stepper("Number of Tickets: \(numberOfTickets)", value: $numberOfTickets, in: 1...10)
                    .padding(.bottom, 10)
                
                let tax = (Double(numberOfTickets) * activity.price) * 0.13
                let price = (Double(numberOfTickets) * activity.price)
                
                Text("Price: $\(price, specifier: "%.2f")")
                    .font(.title)
                
                Text("Tax: $\(tax, specifier: "%.2f")")
                    .font(.title)
                
                let totalprice = price + tax
                Text("Total: $\(totalprice, specifier: "%.2f")")
                    .font(.title)
                    .padding(.bottom, 20)
                
                Button("Confirm Purchase") {
                    let newOrder = PurchaseTicket(name: activity.name, description: activity.description, rating: activity.rating, host: activity.host, price: activity.price, photos: activity.photos, mobileNumber: activity.mobileNumber!, isFavorite: activity.isFavorite, parkLocation: activity.parkLocation, numberOfTickets: numberOfTickets, total: totalprice, tax: tax)
                    self.firedbHelper.insertPurchseList(ticket: newOrder)
                    self.firedbHelper.getAllPurchaseList()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
            .shadow(radius: 5)
            .padding()
        } //body close //body close
        .alert(isPresented: $showingLoginAlert) {
            Alert(
                title: Text("Login Required"),
                message: Text("You need to be logged in to perform this action."),
                primaryButton: .default(Text("Login")) {
                    self.isLogin = true
                },
                secondaryButton: .cancel()
            )
        }
        
    }
    private func initiateTicketPurchase() {
        if appState.isLoggedIn {
            self.showingPurchaseSheet = true
        } else {
            showingLoginAlert = true
            
        }
    }
    
    func callGuide() {
        // Open phone dialer with guide's phone number
        guard let phoneNumber = activity.mobileNumber else {
            return
        }
        
        guard let url = URL(string: "tel://\(phoneNumber)") else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            
        }}
    
    func shareSession() {
        //Open share sheet to share session name and price
        let activityItems: [Any] = [
            "\(activity.name) - $\(activity.price) per person"
        ]
        
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func toggleFavorite() {
        
        if appState.isLoggedIn == false {
            
            //To show the login alert
            showingLoginAlert = true
            
            //getting the current activity name
            self.appState.isLoggedInFavName = self.activity.name
            
            let newSession = Session(
                name: activity.name,
                description: activity.description,
                rating: activity.rating,
                host: activity.host,
                price: activity.price,
                photos: activity.photos,
                mobileNumber: activity.mobileNumber ??  0,
                isFavorite: true,
                parkLocation: activity.parkLocation)
            self.appState.isLoggedInFavSession = newSession
        }
        else {
            if isFav {
                firedbHelper.removeFavorite(withName: activity.name) { success in
                    if success {
                        alertMessage = "Favorite removed successfully"
                        self.firedbHelper.getAllFavSession()
                        isFav = false
                    } else {
                        alertMessage = "Failed to remove favorite"
                    }
                    showAlert = true
                }
            }
            else {
                self.appState.isLoggedInFavName = self.activity.name
                let newSession = Session(name: activity.name, description: activity.description, rating: activity.rating, host: activity.host, price: activity.price, photos: activity.photos, mobileNumber: activity.mobileNumber ??  0, isFavorite: true, parkLocation: activity.parkLocation)
                self.appState.isLoggedInFavSession = newSession
                print("Fasle hai HAI ", activity.isFavorite)
                self.addNewFavorite(withName: self.appState.isLoggedInFavName)
                isFav = true
            }
        }
    }
    
    private func addNewFavorite(withName name: String) {
        if !firedbHelper.favoriteList.contains(where: { $0.name == name }) {
            print("Added new favorite: \(appState.isLoggedInFavName)")
            
            let newFavorite = Session(name: self.appState.isLoggedInFavSession.name, description:   self.appState.isLoggedInFavSession.description , rating:   self.appState.isLoggedInFavSession.rating, host: self.appState.isLoggedInFavSession.host, price: self.appState.isLoggedInFavSession.price, photos: self.appState.isLoggedInFavSession.photos, mobileNumber: self.appState.isLoggedInFavSession.mobileNumber ?? 0, isFavorite: true, parkLocation: self.appState.isLoggedInFavSession.parkLocation)
                firedbHelper.insertFavoriteSession(favorite: newFavorite)
                self.showAlert(message: "Favorlist Added")
        }
    }
    
    private func checkFavorite(withName name: String) {
        if firedbHelper.favoriteList.contains(where: { $0.name == name }) {
            print("new name ", name)
            self.isFav = true
        }
        else{
            self.isFav = false
        }
    }
    
    private func showAlert(message: String) {
          self.alertMessage = message
          self.showAlert = true
    }
    
    func getLocationCoordinates() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(parkAdd) { placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                self.latitude = location.coordinate.latitude
                self.longitude = location.coordinate.longitude
            }
        }
    }
    
    private func openMapForPlace() {
        let coordinates = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.parkAdd
            print("maapppppp",mapItem)
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}
