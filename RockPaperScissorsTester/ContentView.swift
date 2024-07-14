//
//  ContentView.swift
//  RockPaperScissorsTester
//
//  Created by Ayrton Parkinson on 2024/07/13.
//

import SwiftUI

extension View {
    func primaryButton() -> some View {
        foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.capsule)
    }
}

struct ContentView: View {
    @State private var choices = ["Rock 🪨", "Paper 📄", "Scissors ✂️"]
    @State private var choice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    
    @State private var feedbackMessage = ""
    @State private var showFeedback = false
    
    @State private var round = 0
    @State private var showGameOver = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("What \(shouldWin ? "beats" : "is beaten by")...")
            Text(choices[choice])
            Spacer()
            HStack {
                ForEach(choices, id: \.self) { ch in
                    Button(ch) {
                        checkAnswer(ch)
                    }
                    .primaryButton()
                }
            }
            Spacer()
            Text("Score: \(score)")
            Spacer()
        }
        .alert(feedbackMessage, isPresented: $showFeedback) {
            Button("Continue") {
                newRound()
            }
        }
        .alert("Game over!", isPresented: $showGameOver) {
            Button("Play again") {
                resetGame()
            }
        } message: {
            Text("You got \(score) correct")
        }
    }
    
    func checkAnswer(_ guess: String) {
        if (shouldWin && guess == isBeat(by: choices[choice])) || (!shouldWin && choices[choice] == isBeat(by: guess)) {
            feedbackMessage = "Correct!"
            score += 1
        } else {
            feedbackMessage = "Incorrect!"
        }
        
        showFeedback = true
    }
    
    func newRound() {
        round += 1
        
        if round >= 5 {
            showGameOver = true
        } else {
            shouldWin.toggle()
            choice = Int.random(in: 0..<2)
        }
    }
    
    func resetGame() {
        score = 0
        round = 0
        shouldWin.toggle()
        choice = Int.random(in: 0..<2)
    }
    
    func isBeat(by: String) -> String {
        switch by {
        case "Rock 🪨":
            return "Paper 📄"
        case "Paper 📄":
            return "Scissors ✂️"
        case "Scissors ✂️":
            return "Rock 🪨"
        default:
            return ""
        }
    }
}

#Preview {
    ContentView()
}
