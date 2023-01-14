//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Joshua Buhler on 1/14/23.
//

import SwiftUI

struct ContentView: View {
    func doSomething() {
        print ("🦖")
        showingAlert = true
    }
    
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
            
            VStack{
                Text ("Content here")
                    .foregroundStyle(.secondary, .ultraThickMaterial)
                    .padding(50)
                    .background(.ultraThinMaterial)
                Button ("Do Something",
                        action: doSomething)
                .alert("Message", isPresented: $showingAlert) {
                    Button("Make me cry", role: .destructive) { }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Do you really want to hurt me?")
                }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
                Button {
                    print ("b2")
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
            }
        }
        .ignoresSafeArea()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
