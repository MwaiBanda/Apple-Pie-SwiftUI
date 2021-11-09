//
//  ContentView.swift
//  Apple Pie
//
//  Created by Mwai Banda   on 11/10/20.
//

import SwiftUI

struct ContentView: View {
    let buttons = [
        ["A", "B", "C", "D", "E" , "F"],
        ["G", "H", "I", "J", "K" , "L"],
        ["M", "N", "O", "P", "Q" , "R"],
        ["S", "T", "U", "V", "W" , "X"],
        ["Y", "Z"]
    ]
    
    @State var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    
    @State var totalAttempts = 7
    @State var numberOfWins = 0
    @State var numberOfLosses = 0
    @State var index = 0
    @State var numberOfAttempts = 0
    @State var win = false

    var word: String {
        get {
            var word  = ""
            word = listOfWords.first!
            return word
        }
    }
    
    
    var defaultWord: String {
        get {
            var str = ""
            for _ in word {
                str += " _"
            }
            return str
        }
    }
    
    @State var guessedWord = ""
    
    
    
    var body: some View {
        
        VStack (spacing: 12){
            Image("Tree \(totalAttempts)")
                .resizable()
                .aspectRatio(contentMode: .fit)
            if index == 0 || numberOfWins == 0 {
                Text(defaultWord )
                    .font(.system(size: 30))
                    .padding()
            } else {
                Text(guessedWord)
                    .font(.system(size: 30))
                    .padding()
            }
            ForEach(buttons, id: \.self){ row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            if totalAttempts == 0 {
                                totalAttempts = 7
                            }
                            if index == word.count{
                                index = 0
                            }
                            if CheckLetter(guessedLetter: button, index: index) {
                                numberOfWins += 1
                                index += 1
                            } else {
                                totalAttempts -= 1
                                numberOfAttempts += 1
                            }
                            if numberOfAttempts == 7 {
                                listOfWords.removeFirst()
                                print(listOfWords)
                                numberOfAttempts = 0
                                index = 0
                                guessedWord.removeAll()
                            }
                            
                        }, label: {
                            Text(button)
                                .font(.system(size: 30))
                                .foregroundColor(.black)
                                .frame(width: self.getWidth(), height: self.getWidth())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 3)
                                )
                        })
                    }
                }
            }
            Text("Wins: \(numberOfWins)   |   Losses: \(numberOfLosses)")
                .font(.system(size:25))
                .padding(.all, 6)
            Text("Number Of Attempts:  \(numberOfAttempts)/7")
                .font(.system(size:15))
                .padding(.all, 4)
        }
        .padding(.bottom)
    }
    mutating func setdefault(){
        //word = listOfWords.randomElement()!
    }
    func getWidth() -> CGFloat {
        return (UIScreen.main.bounds.width  - 7 * 12) / 6
        // 5 is the number of elements in row
        // 6 is the number of elements in row + 1
        // 12 is the spacing
    }
    func CheckLetter(guessedLetter: String, index: Int) -> Bool {
        let letter = word[ word.index(word.startIndex, offsetBy: index)]
        if String(letter) == guessedLetter.lowercased() {
            print("match")
            UpdateGuess(guessedLetter: guessedLetter, index: index)
            
            return true
        } else {
            print("no-match")
            print(letter)
            print(guessedLetter)
            print(index)
            print(word)
            
            return false
            
        }
    }
    func UpdateGuess(guessedLetter: String, index: Int) {
        let indexItem = guessedWord.index(guessedWord.startIndex, offsetBy: index)
        
        guessedWord.insert(contentsOf: guessedLetter, at: indexItem)
        print("index" ,index)
        print(guessedWord)
        // C_T
        if index == 0 {
            for _ in 0...word.count - 2  {
                guessedWord += "_ "
            }
        }
        if index > 0 {
            guessedWord.remove(at: guessedWord.index(before: guessedWord.endIndex))
            guessedWord.remove(at: guessedWord.index(before: guessedWord.endIndex))
        }
        print(guessedWord)
    }
    func checkWin() {
        if guessedWord == word{
            win = true
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

