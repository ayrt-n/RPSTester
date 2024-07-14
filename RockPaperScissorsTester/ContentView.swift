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
                ForEach(choices, id: \.self) { choice in
                    Button(choice) {
                        checkAnswer(guess: choice)
                    }
                    .primaryButton()
                }
            }
            Spacer()
            Text("Score: \(score)")
            Spacer()
        }
        .alert(feedbackMessage, isPresented: $showFeedback) {
            Button("OK") {
                newRound()
            }
        }
        .alert("Game over!", isPresented: $showGameOver) {
            Button("Play again") {
                
            }
        } message: {
            Text("You got \(score) correct")
        }
    }
    
    func checkAnswer(guess: String) {
        feedbackMessage = "Good job!"
        score += 1
        showFeedback = true
    }
    
    func newRound() {
        round += 1
        
        shouldWin.toggle()
        choice = Int.random(in: 0..<2)
        
        if round >= 2 {
            score = 0
            showGameOver = true
        }
    }
}

#Preview {
    ContentView()
}
