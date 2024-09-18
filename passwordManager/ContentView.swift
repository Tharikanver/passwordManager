//
//  ContentView.swift
//  passwordManager
//
//  Created by Tharik on 17/09/24.
//
import SwiftUI

struct ContentView: View {
    @FetchRequest(entity: Account.entity(), sortDescriptors: [])
    var accounts: FetchedResults<Account>
    
    @State private var isShowingAddNewAccount = false
    @State private var selectedAccount: Account? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Text("Password Manager")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding([.top, .leading])
                        Spacer()
                    }
                    
                    List {
                        ForEach(accounts, id: \.self) { account in
                            Button(action: {
                                selectedAccount = account
                            }) {
                                HStack {
                                    Text(account.accountName ?? "Unknown")
                                    Spacer()
                                    Text("•••••••••")
                                        .font(.system(size: 18, weight: .medium, design: .monospaced))
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.blue)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.vertical, 8)
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: deleteAccount)
                    }
                    .listStyle(PlainListStyle())
                    .padding()
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            isShowingAddNewAccount.toggle()
                        }) {
                            Image(systemName: "plus.app.fill")
                                .font(.system(size: 56))
                                .foregroundColor(.blue)
                                .padding()
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowingAddNewAccount) {
                AddNewAccountView()
                    .presentationDetents([.fraction(0.5)])
                    .ignoresSafeArea(.keyboard)
            }
            .sheet(item: $selectedAccount) { account in
                AccountDetailView(account: account)
                    .presentationDetents([.fraction(0.5)])
            }
        }
    }
    
    func deleteAccount(at offsets: IndexSet) {
        for index in offsets {
            let account = accounts[index]
            PersistenceController.shared.delete(account)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
