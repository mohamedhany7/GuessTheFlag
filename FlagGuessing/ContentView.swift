//
//  ContentView.swift
//  FlagGuessing
//
//  Created by Mohamed Hany on 09/06/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAnswer = false
    @State private var showingFinalScore = false
    @State private var alertMessage = ""
    @State private var finalScoreTitle = ""
    @State private var finalAlertMessage = ""
    @State private var score = 0
    @State private var rounds = 0
    private var maxRounds = 4
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        VStack(spacing: 30) {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.white)
                    Spacer()
                    
                    VStack{
                        VStack() {
                            Text("Tap the flag of")
                                .foregroundStyle(.secondary)
                                .font(.subheadline.bold())
                            Text(countries[correctAnswer])
                                .font(.largeTitle.bold())
                        }

                        ForEach(0..<3) { number in
                            Button {
                                rounds += 1
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .renderingMode(.original)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Spacer()
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                        .font(.title.bold())
                    Spacer()
                }
                .padding()
            }
            .alert("Wrong", isPresented: $showingAnswer) {
                Button("Continue", action: askQuestion)
            } message: {
                Text(alertMessage)
            }
            .alert(finalScoreTitle, isPresented: $showingFinalScore) {
                Button("Restart", action: restartGame)
            } message: {
                Text(finalAlertMessage)
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            if (rounds != maxRounds){
                askQuestion()
            }
        } else {
            score -= 1
            alertMessage = "That’s the flag of \(countries[number])"
            showingAnswer = true
        }
        
        if (rounds == maxRounds){
            if (score > 0){
                finalScoreTitle = "Congratulations!"
                finalAlertMessage = "You won \n Your score is \(score)"
            }else{
                finalScoreTitle = "Game Over!"
                finalAlertMessage = "You lost \n Your score is \(score)"
            }
            showingFinalScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame(){
        rounds = 0
        score = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
