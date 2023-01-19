//
//  ContentView.swift
//  Day25_rps
//
//  Created by Josh Buhler on 1/19/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentRound:Int = 0
    @State var maxRounds:Int = 10
    
    @State var totalPoints:Int = 0
    
    @State var shouldWin:Bool = Bool.random()
    @State var cpuChoice:Int = Int.random(in: 0..<2)
    
    @State var displayGameOver = false
    
    var options = ["Rock", "Paper", "Scissors"]
    
    func checkResult (selected:Int) {
        var correctAnswer = false
        
        if (shouldWin) {
            if (selected == (cpuChoice + 1) || selected == (cpuChoice - 2)) {
                correctAnswer = true
            }
        } else {
            if (selected == (cpuChoice - 1) || selected == (cpuChoice + 2)) {
                correctAnswer = true
            }
        }
        
        if (correctAnswer) {
            totalPoints += 1
        }
        
        shouldWin.toggle()
        cpuChoice = Int.random(in: 0..<2)
        
        currentRound += 1
        if (currentRound >= maxRounds) {
            displayGameOver = true
        }
    }
    
    
    var body: some View {
        VStack {
            HStack{
                Text("Score: \(totalPoints)")
                Text("Round: \(currentRound)")
            }
            Spacer()
            
            Text("\(options[cpuChoice].uppercased())… I choose you!")
                .font(.largeTitle)
            Spacer()
            
            Text("You should…")
            Spacer()
            Text(shouldWin ? "WIN" : "LOSE")
                .font(.largeTitle)
            
            Spacer()
            
            HStack {
                Spacer()
                Button("🪨") {
                    checkResult(selected: RPS.rock.rawValue)
                }
                Spacer()
                Button("📄") {
                    checkResult(selected: RPS.paper.rawValue)
                }
                Spacer()
                Button("✂️") {
                    checkResult(selected: RPS.scissors.rawValue)
                }
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .alert("Game Over", isPresented: $displayGameOver) {
            Button("OK") {
                currentRound = 0
                totalPoints = 0
            }
        } message: {
            Text("Final Score: \(totalPoints)")
        }
    }
}

enum RPS:Int {
    case rock
    case paper
    case scissors
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
