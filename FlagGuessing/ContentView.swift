//
//  ContentView.swift
//  FlagGuessing
//
//  Created by Mohamed Hany on 09/06/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""

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
                    Text("Score: ???")
                        .foregroundColor(.white)
                        .font(.title.bold())
                    Spacer()
                }
                .padding()
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is ???")
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }

        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
