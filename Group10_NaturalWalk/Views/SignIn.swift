//
//  SignIn.swift
//  Group7_NaturalWalk
//
//  Created by Darksun on 2024-07-07.
//
import SwiftUI

struct SignIn: View {
    
    @State private var showAlert = false
    @State private var alertMessage = ""

    @State private var email : String = ""
    @State private var password : String = ""
    @State private var showSignUp : Bool = false
    @State private var showSignIn : Bool = false
    @State private var homeSelection : Int? = nil
    @ObservedObject var appState : AppState
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var firedbHelper : FireDBHelper
    
    private let gridItems : [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                // Logo or App Name
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                
                // Input Fields
                VStack(spacing: 20) {
                    TextField("Enter Email", text: self.$email)
                        .padding()
                        .font(.custom("Avenir-Heavy", size: 20))
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    
                    SecureField("Enter Password", text: self.$password)
                        .padding()
                        .font(.custom("Avenir-Heavy", size: 20))
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                }
                .padding(.horizontal, 30)
                
                // Buttons
                VStack(spacing: 15) {
                    Button(action: {
                        isValid()
                    }) {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        self.showSignUp = true
                    }) {
                        Text("No Account? Create one here :)")
                            .font(.custom("Avenir-Heavy", size: 16))
                            .foregroundColor(.blue)
                            .bold()
                            .frame(maxWidth: .infinity)
                    }
                    
                }
                .padding(.horizontal, 30)
                Spacer()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Login"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            self.email = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        }
        .background(
            NavigationLink(destination: MainScreen().environmentObject(appState), isActive: $showSignIn) { EmptyView() }
        )
        .background(
            NavigationLink(destination: SignUp().environmentObject(fireAuthHelper).environmentObject(firedbHelper).environmentObject(appState), isActive: $showSignUp) { EmptyView() }
        )
    }
    
    //if the session is available in firebase call addfavourite otherwise don't
    private func handleFavoriteLogic() {
        self.firedbHelper.fetchSessionName(name: appState.isLoggedInFavName) { fetchedIDs in
            if !fetchedIDs.isEmpty {
                self.addNewFavorite(withName: self.appState.isLoggedInFavName)
                print("Fetched IDs for name: ", self.appState.isLoggedInFavName)
            }
            else {
                self.showAlert(message: "No IDs fetched for the given name")
            }
            print("SESSION DOC ID : ", fetchedIDs)
        }
    }
    
    private func addNewFavorite(withName name: String) {
        if !firedbHelper.favoriteList.contains(where: { $0.name == name }) {
            print("Added new favorite: \(appState.isLoggedInFavName)")
            
            let newFavorite = Session(name: self.appState.isLoggedInFavSession.name,
                                      description: self.appState.isLoggedInFavSession.description,
                                      rating: self.appState.isLoggedInFavSession.rating,
                                      host: self.appState.isLoggedInFavSession.host,
                                      price: self.appState.isLoggedInFavSession.price,
                                      photos: self.appState.isLoggedInFavSession.photos,
                                      mobileNumber: self.appState.isLoggedInFavSession.mobileNumber ?? 0,
                                      isFavorite: self.appState.isLoggedInFavSession.isFavorite,
                                      parkLocation: self.appState.isLoggedInFavSession.parkLocation)
            firedbHelper.insertFavoriteSession(favorite: newFavorite)
        } else {
            self.showAlert(message: "The session is already is in favorite")
        }
    }
    
    private func isValid() {
           if email.isEmpty && password.isEmpty {
               showAlert(message: "Please enter both email and password.")
           } else if email.isEmpty {
               showAlert(message: "Please enter your email.")
           } else if password.isEmpty {
               showAlert(message: "Please enter your password.")
           } else {
               // Proceed with sign in
               fireAuthHelper.signIn(email: email, password: password) { success, error in
                   if success {
                       print("Signed in successfully")
                       self.firedbHelper.initializeFavoriteList()
                       self.firedbHelper.initializePurchaseList()
                       self.handleFavoriteLogic()
                       self.showSignIn = true
                       self.appState.isLoggedIn = true
                   } else {
                       showAlert(message: "Email ID And/Or Password Is Wrong")
                   }
               }
           }
       }
       
       private func showAlert(message: String) {
           self.alertMessage = message
           self.showAlert = true
       }
}

