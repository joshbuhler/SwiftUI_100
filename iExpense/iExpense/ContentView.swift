//
//  ContentView.swift
//  iExpense
//
//  Created by Josh Buhler on 5/18/23.
//

import SwiftUI

class User:ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct ContentView: View {
    
    @StateObject var user = User()
    
    @State private var showingSheet = false
    
    var body: some View {
        
        VStack {
            Text("Your name is: \(user.firstName) \(user.lastName)")
            
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
            
            Button("Show Sheet") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SecondView(name: user.firstName)
            }
            
        }
        .padding()
    }
}

struct SecondView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let name:String
    
    var body: some View {
        VStack {
            Text("Hello \(name)")
            Button ("Dismiss") {
                dismiss()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
