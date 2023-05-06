//
//  ContentView.swift
//  WordScramble
//
//  Created by Joshua Buhler on 5/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var playerScore = 0
    
    @State private var spelledRight = true
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .onSubmit(addNewWord)
                }
                
                Section ("Words Found") {
                    Text("\(usedWords.count)")
                }
                
                Section {
                    ForEach (usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("Start Over") {
                    startGame()
                }
            }
        }
        .onAppear(perform: startGame)
        .alert(errorTitle,
               isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
    
    func startGame() {
        
        usedWords.removeAll()
        playerScore = 0
        
        guard let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
              let startWords = try? String(contentsOf: startWordsURL) else {
            
            fatalError("Could not load start.txt from bundle.")
        }
        
        let allWords = startWords.components(separatedBy: "\n")
        rootWord = allWords.randomElement() ?? "silkworm"
        
    }
    
    func addNewWord () {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !answer.isEmpty else {
            return
        }
        
        guard tooShort(word: answer) else {
            wordError(title: "Word is too short", message: "Think big")
            return
        }
        
        guard notRoot(word: answer) else {
            wordError(title: "That doesn't count", message: "Boring")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard spellCheck(text: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func tooShort (word:String) -> Bool {
        word.count > 2
    }
    
    func notRoot (word:String) -> Bool {
        word != rootWord
    }
    
    func isOriginal (word:String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible (word:String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func spellCheck (text:String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: text.utf16.count)
        
        let bad = checker.rangeOfMisspelledWord(in: text, range: range, startingAt: 0, wrap: false, language: "en")
        
        return bad.location == NSNotFound
    }
    
    func wordError(title:String, message:String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
