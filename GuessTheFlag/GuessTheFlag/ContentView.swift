//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Joshua Buhler on 1/14/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var flagSelected = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var currentScore = 0
    @State private var currentRound = 1
    private var maxRounds = 8
    
    @State private var gameOver = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            //            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center).ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.custom("Aero Matics Regular", size: 24))
                    .foregroundColor(.white)
                Spacer()
                Spacer()
                Text("Score: \(currentScore)/\(maxRounds)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Text("Current Round: \(currentRound)")
                    .foregroundColor(.white)
                    .font(.custom("Aero Matics Display Bold", size: 18))
                Spacer()
                VStack(spacing: 15) {
                    VStack{
                        Text("Tap the flag of…")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("You picked: \(countries[flagSelected])\nYour score is: \(currentScore)")
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("New Game", action: newGame)
        } message: {
            Text("Your score is: \(currentScore)")
        }
    }
    
    func flagTapped(_ number:Int) {
        flagSelected = number
        if (number == correctAnswer) {
            scoreTitle = "Correct"
            currentScore += 1
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
        
        if (currentRound >= maxRounds) {
            gameOver = true
        }
        currentRound += 1
    }
    
    func askQuestion () {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func newGame () {
        currentScore = 0
        currentRound = 1
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
