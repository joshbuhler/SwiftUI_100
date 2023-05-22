//
//  ContentView.swift
//  Moonshot
//
//  Created by Joshua Buhler on 5/20/23.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        
//        GeometryReader { geo in
//            Image("bronco_01")
//                .resizable()
//                .scaledToFit()
//                .frame(width: geo.size.width * 0.8)
//                .frame(width: geo.size.width, height: geo.size.height)
//        }
        
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText("Item: \($0)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("CustomText \(text)")
        self.text = text
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
