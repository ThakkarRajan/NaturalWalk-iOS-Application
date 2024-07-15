//
//  FireAuthHelper.swift
//  Group7_NaturalWalk
//
//  Created by Darksun on 2024-07-07.
//

import Foundation
import FirebaseAuth

class FireAuthHelper: ObservableObject{
    
    @Published var user : User?{
        didSet{
            objectWillChange.send()
        }
    }
    
    private static var shared : FireAuthHelper?
    
    static func getInstance() -> FireAuthHelper{
        
        if (shared == nil){
            shared = FireAuthHelper()
        }
        return shared!
    }
    
    func listenToAuthState(){
        Auth.auth().addStateDidChangeListener{[weak self] _, user in
            guard let self = self else{
                return
            }
            self.user = user
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let user = authResult?.user {
                
                UserDefaults.standard.set(user.email, forKey: "KEY_EMAIL")
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }  
    }
    
    func signOut(){
            do{
                FireDBHelper.getInstance().sessionList.removeAll()

                FireDBHelper.getInstance().insertSessionsList()
                try Auth.auth().signOut()
                UserDefaults.standard.set(self.user?.email, forKey: "")
               
            }catch let error{
                print(#function, "Unable to sign out user: \(error)")
            }
        }
  
    func signIn(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                print(#function, "Error while signing in: \(error.localizedDescription)")
                completion(false, error)
                return
            }
            
            guard let user = authResult?.user else {
                print(#function, "No user data received")
                completion(false, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user data received"]))
                return
            }
            
            print(#function, "Successfully signed in: \(user.uid)")
            
            // Update the user property
            self?.user = user
            
            // Store user information in UserDefaults
            UserDefaults.standard.set(user.email, forKey: "KEY_EMAIL")
            
            // Notify of successful sign-in
            completion(true, nil)
        }
    }
}

