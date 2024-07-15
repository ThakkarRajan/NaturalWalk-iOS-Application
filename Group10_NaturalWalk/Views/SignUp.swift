import SwiftUI

struct SignUp: View {
    
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var phonenumber: String = ""
    @State private var address: String = ""
    @State private var showSignIn: Bool = false
    
    @EnvironmentObject var fireAuthHelper: FireAuthHelper
    @EnvironmentObject var firedbHelper: FireDBHelper
    @EnvironmentObject var appState: AppState
    
    var isFormValid: Bool {
        !email.isEmpty &&
        !name.isEmpty &&
        !password.isEmpty &&
        !confirmPassword.isEmpty &&
        !phonenumber.isEmpty &&
        !address.isEmpty &&
        password == confirmPassword
    }
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
            
            TextField("Enter Name", text: self.$name)
                .padding()
                .font(.custom("Avenir-Heavy", size: 20))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            
            TextField("Enter Email", text: self.$email)
                .padding()
                .font(.custom("Avenir-Heavy", size: 20))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            
            TextField("Enter Contact Number", text: self.$phonenumber)
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
            
            SecureField("Enter Password Again", text: self.$confirmPassword)
                .padding()
                .font(.custom("Avenir-Heavy", size: 20))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            
            TextField("Enter Address", text: self.$address)
                .padding()
                .font(.custom("Avenir-Heavy", size: 20))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            
            Section {
                Button(action: {
                    let newUser = UserProfile(email: self.email, name: self.name, phoneNumber: self.phonenumber, address: self.address)
                    
                    self.firedbHelper.insertUser(user: newUser)
                    
                    fireAuthHelper.signUp(email: email, password: password) { success, error in
                        if success {
                            let newUser = UserProfile(email: self.email, name: self.name, phoneNumber: self.phonenumber, address: self.address)
                            self.firedbHelper.insertUser(user: newUser)
                            self.showSignIn = true
                        } else {
                            print("Unknown error occurred")
                        }
                    }
                }) {
                    Text("Create Account")
                        .font(.custom("Avenir-Heavy", size: 20))
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isFormValid ? Color.blue : Color.gray)
                        .cornerRadius(10)
                }
                .disabled(!isFormValid)
                .background(
                    NavigationLink(destination: SignIn(appState: appState), isActive: $showSignIn) { EmptyView() }
                )
                Spacer()
            }
            .padding()
        }
        .padding()
    }
}
