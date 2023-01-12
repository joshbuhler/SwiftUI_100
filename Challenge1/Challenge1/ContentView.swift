//
//  ContentView.swift
//  Challenge1
//
//  Created by Josh Buhler on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var input = 100.0
    @State private var inputUnit = UnitLength.meters
    @State private var outputUnit = UnitLength.kilometers
    
    let units:[UnitLength] = [.miles, .feet, .inches, .kilometers, .meters, .centimeters, .millimeters, .fathoms]
    
    @FocusState private var inputIsFocused: Bool
    
    let measurementFormatter:MeasurementFormatter
    
    init() {
        measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitOptions = .providedUnit
        measurementFormatter.unitStyle = .long
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Amount to convert")
                }
                
                Picker("Convert from", selection: $inputUnit) {
                    ForEach(units, id: \.self) {
                        Text(measurementFormatter.string(from: $0).capitalized)
                    }
                }
                
                Picker("Convert to", selection: $outputUnit) {
                    ForEach(units, id: \.self) {
                        Text(measurementFormatter.string(from: $0).capitalized)
                    }
                }
                
                Section {
                    Text(result)
                } header: {
                    Text("Result")
                }
            }
        }
        .navigationTitle("Converter")
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    inputIsFocused = false
                }
            }
        }
    }
    
    var result: String {
        let inputMeasurement = Measurement(value: input, unit: inputUnit)
            let outputMeasurement = inputMeasurement.converted(to: outputUnit)
            return measurementFormatter.string(from: outputMeasurement)
    }
}

///
/// So... I clearly didn't pay attention, and got a super-busted thing going on
/// below, because I started thinking about things in a UIKit-based way instead
/// of SwiftUI. Wanted to do a sort of "picker.onchange" pattern, instead of
/// changing the @State var, and letting SwiftUI call a computed property, as in
/// the tutorial solution. Keeping my busted version around, to compare against
/// the solution.

    ///
//    @State var inputUnit:Double = 0.0
//    @State var inputSelection:Int = 0 {
//        didSet {
//            convertUnit()
//        }
//    }
//
//
//
//    @State var outputSelection:Int = 0 {
//        didSet {
//            convertUnit()
//        }
//    }
    
//    @State var convertedUnit:Double = 0.0
//
//    let unitOptions:[UnitLength] = [.miles, .feet, .inches, .kilometers, .meters, .centimeters, .millimeters, .fathoms]
//
//
//    func convertUnit () {
//
//        let measurement = Measurement(value: inputUnit, unit: unitOptions[inputSelection])
//        let output = measurement.converted(to: unitOptions[outputSelection])
//        convertedUnit = output.value
//    }
//
//    var body: some View {
//        Form {
//            Section {
//                HStack {
//                    TextField("Unit to convert",
//                              value: $inputUnit,
//                              format: .number )
//                    Picker("Unit", selection: $inputSelection) {
//                        ForEach(0 ..< unitOptions.count) {
//                            Text("\($0)")
//                        }
//                    }
//                }
//            } header: {
//                Text("Starting Unit")
//            }
//
//            Section {
//                HStack {
//                    Text("\(convertedUnit)")
//                    Picker("Unit", selection: $outputSelection) {
//                        ForEach(0 ..< unitOptions.count) {
//                            Text("\($0)")
//                        }
//                    }
//                }
//            } header: {
//                Text("Ending Unit")
//            }
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
