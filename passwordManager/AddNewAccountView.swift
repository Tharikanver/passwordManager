//
//  AddNewAccountView.swift
//  passwordManager
//
//  Created by Tharik on 17/09/24.
//

import SwiftUI

struct AddNewAccountView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var accountName = ""
    @State private var emailOrUsername = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Add New Account Details")
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding(.leading , 10)
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .padding()
                        .shadow(radius: 3)
                }
                .padding()
            }
            
            
            Spacer()
            
            TextField("Account Type", text: $accountName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Username / Email", text: $emailOrUsername)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: validateAndSaveAccount) {
                Text("Add New Account")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(20)
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
    
    func validateAndSaveAccount() {
        if emailOrUsername != emailOrUsername.lowercased() {
            alertMessage = "Email must start with lowercase letters."
            showAlert = true
        } else if password.count < 8 {
            alertMessage = "Password must be at least 8 characters long."
            showAlert = true
        } else {
            let newAccount = Account(context: PersistenceController.shared.viewContext)
            newAccount.accountName = accountName
            newAccount.emailOrUsername = emailOrUsername
            newAccount.password = password
            
            PersistenceController.shared.save()
            presentationMode.wrappedValue.dismiss()
        }
    }
}


struct AddNewAccountView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewAccountView()
    }
}
