//
//  ContentView.swift
//  BetterRest
//
//  Created by Joshua Buhler on 4/29/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    @State private var coffeeAmount = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Text("When do you want to wake up?")
                    .font(.headline)
                
                Stepper("\(sleepAmount.formatted())", value: $sleepAmount)
                
                DatePicker("Please enter a time",
                           selection: $wakeUp,
                           in: Date.now...,
                           displayedComponents: .hourAndMinute)
                .labelsHidden()
                
                Text("Daily coffee intake")
                    .font(.headline)
                Stepper(coffeeAmount == 1 ? "1 Cup" : "\(coffeeAmount) Cups", value: $coffeeAmount)
            }
        }
        .navigationTitle("BetterRest")
        .toolbar {
            Button("Calculate", action: calculateBedtime)
        }
    }
    
    func calculateBedtime() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
