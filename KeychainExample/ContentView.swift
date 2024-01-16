//
//  ContentView.swift
//  KeychainExample
//
//  Created by User on 11.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var password = ""
    @State private var account = ""
    @State private var status = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("My password is", text: $password)
                    .textFieldStyle(.roundedBorder)
                TextField("My account is", text: $account)
                    .textFieldStyle(.roundedBorder)
                Button("Saved data") {
                    do {
                        status = try KeychainManager.save(
                            password: password.data(using: .utf8) ?? Data(),
                            account: account
                        )
                    } catch {
                        print(error)
                    }
                }
                Button("See my password") {
                    do {
                        let data = try KeychainManager.getPassword(for: account)
                        status = String(decoding: data ?? Data(), as: UTF8.self)
                    } catch {
                        print(error)
                    }
                }
                Text(status)
                    .font(.largeTitle)
                    .foregroundColor(.red)
            }
            .padding()
            .navigationTitle("Save your Password")
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
