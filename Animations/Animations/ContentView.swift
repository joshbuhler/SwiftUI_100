//
//  ContentView.swift
//  Animations
//
//  Created by Joshua Buhler on 5/6/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 1.0
    @State private var enabled = false
    
    var body: some View {
        
        print ("animationAmount: \(animationAmount)")
        
        return VStack {
            Stepper("Scale amount",
                     value: $animationAmount.animation(
                        .easeInOut(duration: 1).repeatCount(3, autoreverses: true)),
                     in: 1...10)
            
            Spacer()
            
            Button("Tap Me") {
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    animationAmount += 360
                }
            }
            .padding(40)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 0, z: 1))
//            .scaleEffect(animationAmount)
            
            Button("Tap Me") {
                // do nothing
                enabled.toggle()
            }
            .frame(width: 200, height: 200)
            .background(enabled ? .blue : .red)
            .animation(nil, value: enabled)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
            
            Button("Tap Me") {
                // do nothing
            }
            .frame(width: 200, height: 200)
            .background(.blue)
            .foregroundColor(.white)
            
        }
        
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
