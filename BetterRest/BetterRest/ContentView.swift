//
//  ContentView.swift
//  BetterRest
//
//  Created by Joshua Buhler on 4/29/23.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
        
    var body: some View {
        NavigationView {
            
            VStack {
                Form {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        Stepper("\(sleepAmount.formatted())", value: $sleepAmount)
                    }
                    
                    Section("What time would you like to wake up?") {
                        DatePicker("Please enter a time to wake up",
                                   selection: $wakeUp,
                                   displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    }
                    
                    Section {
                        Stepper(coffeeAmount == 1 ? "1 Cup" : "\(coffeeAmount) Cups", value: $coffeeAmount)
                    } header: {
                        Text("Daily coffee intake")
                            .font(.headline)
                    }
                    
                }
                
                VStack {
                    Text("You should go to bed at…")
                        .font(.title)
                    Text(targetBedtime)
                }
            }
            .navigationTitle("BetterRest")
        }
    }
    
    static var defaultWakeTime:Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    
    var targetBedtime:String {
        return calculateBedtime()
    }
    
    func calculateBedtime() -> String {
        
        var bedtime = "RIGHT NOW"
        
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute),
                                                  estimatedSleep: sleepAmount,
                                                  coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            bedtime = sleepTime.formatted(date: .omitted,
                                               time: .shortened)

        } catch {
//            alertTitle = "Error"
//            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
//        showingAlert = true
        return bedtime
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
