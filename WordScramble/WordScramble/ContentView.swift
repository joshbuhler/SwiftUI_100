//
//  ContentView.swift
//  WordScramble
//
//  Created by Joshua Buhler on 5/6/23.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
    @State private var spelledRight = true
    
    var body: some View {
        //            List(people, id: \.self) {
        //                Text($0)
        //            }
        
        // ...is basically the same as...
        List {
            Text("Static Row")
            
            ForEach(people, id: \.self) {
                Text($0)
            }
            
            Text("Static Row")
            
            Button("Check") {
                spelledRight = spellCheck(text: "word")
            }
            
            HStack {
                Text("Spelled right:")
                Text((spelledRight ? "yes" : "no"))
            }
        }
    }
    
    func spellCheck (text:String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: text.utf16.count)
        
        let bad = checker.rangeOfMisspelledWord(in: text, range: range, startingAt: 0, wrap: false, language: "en")
        
        return bad.location == NSNotFound
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
