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

struct CodableUser:Codable {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct ContentView: View {
    
    @StateObject var user = User()
    
    @State private var showingSheet = false
    
    @State private var numbers = [Int]()
    @AppStorage("tapCount") private var currentNumber = 0
    
    @State private var cUser = CodableUser(firstName: "Taylor", lastName: "Swift")
    
    var body: some View {
        
        NavigationView {
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
                
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row: \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button ("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                Spacer()
                Button("Save User") {
                    let encoder = JSONEncoder()

                    if let data = try? encoder.encode(cUser) {
                        UserDefaults.standard.set(data, forKey: "UserData")
                    }
                }
            }
            .toolbar {
                EditButton()
            }
        }
        .padding()
        
    }
    
    func removeRows(at offsets:IndexSet) {
        numbers.remove(atOffsets: offsets)
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
