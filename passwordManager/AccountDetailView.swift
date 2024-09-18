//
//  AccountDetailView.swift
//  passwordManager
//
//  Created by Tharik on 17/09/24.
//

import SwiftUI

struct AccountDetailView: View {
    @ObservedObject var account: Account
    @State private var isEditing = false
    @State private var showPassword = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Text("Account Details")
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .padding(16)
                        .shadow(radius: 3)
                }
                .padding(.trailing, 16)
            }
            
            Spacer()
            
            if isEditing {
                TextField("Account Type", text: Binding(
                    get: { account.accountName ?? "" },
                    set: { account.accountName = $0 }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                TextField("Username / Email", text: Binding(
                    get: { account.emailOrUsername ?? "" },
                    set: { account.emailOrUsername = $0 }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                SecureField("Password", text: Binding(
                    get: { account.password ?? "" },
                    set: { account.password = $0 }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                Button("Save") {
                    PersistenceController.shared.save()
                    isEditing = false
                }
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(20)
            } else {
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Account Type: ")
                            .font(.subheadline)
                        Text(account.accountName ?? "Unknown")
                            .font(.headline)
                    }
                    Spacer()
                }
                .padding()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Username / Email: ")
                            .font(.subheadline)
                        Text(account.emailOrUsername ?? "Unknown")
                            .font(.headline)
                    }
                    Spacer()
                }
                .padding()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Password: ")
                            .font(.subheadline)
                        Text(showPassword ? (account.password ?? "") : "•••••••••")
                            .font(.headline)
                    }
                    Spacer()
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                
                HStack {
                    Button("Edit") {
                        isEditing = true
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(20)
                    
                    Spacer()
                    
                    Button(action: deleteAccount) {
                        Text("Delete")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(20)
                }
                .padding()
            }
        }
        .padding()
        .edgesIgnoringSafeArea(.top)
    }
    
    func deleteAccount() {
        PersistenceController.shared.delete(account)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let account = Account()
        account.accountName = "hiii"
        
        
        return AccountDetailView(account: account)
    }
}

