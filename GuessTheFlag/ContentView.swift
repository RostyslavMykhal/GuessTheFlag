//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Elliott Miller on 01.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Poland", "UK", "Ukraine", "US"]
    // funny answers
    @State private var trueAnswers = ["YES!", "You're goddanm right..🥸","Correct! 🤓", "Well Done!", "More points!", "MORE POINTS!!! 🤩", "Show must go on 🕺🏼"]
    @State private var falseAnswers = ["You lose :(", "Wrong!😓", "You can better!🥺", "Take it seriously ☹️", "Think more please 🙏"]
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scores = 0
    
    func getRandomTrueAnswer() -> String {
        if let randomElement = trueAnswers.randomElement() {
            return randomElement
        } else {
            // Handle the case where the array is empty
            return "No answers available"
        }
    }
    func getRandomFalseAnswer() -> String{
        if let randomElement = falseAnswers.randomElement() {
            return randomElement
        } else {
            return "No answers available"
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = getRandomTrueAnswer()
            scores += 1
        } else {
            scoreTitle = getRandomFalseAnswer()
            scores = 0
        }
        showingScore = true
        
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 1...2)
    }
    var body: some View {
        
        ZStack{
                        LinearGradient(colors: [.purple, .black], startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
//            RadialGradient(stops: [
//                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
//                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
//            ], center: .top, startRadius: 200, endRadius: 400)
//            .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing:15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                    }
                    .font(.subheadline.weight(.heavy))
                    .font(.largeTitle.weight(.semibold))
                    
                    ForEach(0..<3){ number in
                        Button(){
                            //flag was tapped
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
            }
            .padding()
            
            
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scores)")
                .foregroundStyle(.white)
                .font(.title.bold())
            
        }
    }
}
#Preview {
    ContentView()
}
