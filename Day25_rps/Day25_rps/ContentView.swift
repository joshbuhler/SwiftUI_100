//
//  ContentView.swift
//  Day25_rps
//
//  Created by Josh Buhler on 1/19/23.
//

import SwiftUI

struct ContentView: View {
    
    var currentRound:Int = 0
    var maxRounds:Int = 10
    
    @State var totalPoints:Int = 0
    
    @State var shouldWin:Bool = true
    @State var cpuChoice:Int = 0
    
    var options = ["Rock", "Paper", "Scissors"]
    
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            HStack {
                Button("🪨") {
                    print ("ROCK")
                }
                Button("📄") {
                    print ("PAPER")
                }
                Button("✂️") {
                    print ("SCISSORS")
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
