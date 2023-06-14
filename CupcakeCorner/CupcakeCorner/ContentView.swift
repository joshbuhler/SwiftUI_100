//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Joshua Buhler on 6/6/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)",
                            value: $order.quantity)
                }
                
                Section {
                    Toggle("Any special requests?",
                           isOn: $order.specialRequestEnabled.animation())
                    
                    if (order.specialRequestEnabled) {
                        Toggle("Extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add Sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery Details")
                    }

                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
