//
//  ContentView.swift
//  WeSplit
//
//  Created by Josh Buhler on 1/5/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused:Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var grandTotal:Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson:Double {
        let peopleCount = Double(numberOfPeople + 2)
        
        let amountPerPerson = self.grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    @State private var moneyFormatter:NumberFormatter = {
        var f = NumberFormatter()
        f.numberStyle = .currency
        f.currencyCode = Locale.current.currency?.identifier ?? "USD"
        
        return f
    }()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount",
                              value: $checkAmount,
                              formatter: moneyFormatter) {
                    }
                              .focused($amountIsFocused)
                              .keyboardType(.decimalPad)
                    // --OR this. Just keeping them both for my own reference.--
                    TextField("Amount",
                              value: $checkAmount,
                              format: .currency(code: moneyFormatter.currencyCode))
                    .focused($amountIsFocused)
                    
                    
                    Picker("Number of people",
                           selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
//                    Picker("Tip Percentage",
//                           selection: $tipPercentage) {
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        }
//                    }
//                           .pickerStyle(.segmented)
                    
                    Picker("Tip Percentage",
                           selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                           .pickerStyle(.navigationLink)
                } header: {
                    Text("Tip Amount?")
                }
                
                Section {
                    Text(grandTotal,
                         format: .currency(code: moneyFormatter.currencyCode))
                } header: {
                    Text ("Grand Total")
                }
                
                Section {
                    Text(totalPerPerson,
                         format: .currency(code: moneyFormatter.currencyCode))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
