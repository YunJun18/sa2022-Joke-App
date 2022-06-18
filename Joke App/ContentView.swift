//
//  ContentView.swift
//  Joke App
//
//  Created by T Krobot on 11/6/22.
//

import SwiftUI

struct ContentView: View {
    
    var jokes = [
        Joke(setup: "Why did the chicken cross the road?", punchline: "To get to the other side🐥"),
        Joke(setup: "I think nasa is doing something wrong.", punchline: "Because she has a whole universe in her eye🌎"),
        Joke(setup: "My mum told me to chase my dream and I obeyed!", punchline: "I ran far far away🏃🏻‍♀️"),
        Joke(setup: "Are you a parking fine🅿️?", punchline: "Everyone said your face looks fine!"),
        Joke(setup: "How do celebrities stay cool?", punchline: "They have many fans")
    ]
    
    @State var isPunchlineShown = false
    @State var jokeIndex = 0
    @State var isAlertShown = false
    @State var isSheetShown = false
    @State var gotPositiveFeedback = false // show happy or sad paw patrol
    @State var punchlineRotation: Angle = .zero
    
    @State var punchlineSize = 0.1
    @State var taptoContinueYOffset = 300.0
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {

                    if isPunchlineShown {
                        jokeIndex += 1
                        isPunchlineShown = false
                        if jokeIndex == jokes.count {
                            jokeIndex = 0
                        }
                        isAlertShown = true
                    }
                }
            VStack {
                Text(jokes[jokeIndex].setup)
                    .padding()
                Button {
                    withAnimation {
                        isPunchlineShown = true
                    }
                } label: {
                    Text("*Tell* me!")
                        .padding()
                        .foregroundColor(.white)
                }
                
                if isPunchlineShown {
                    Text(jokes[jokeIndex].punchline)
                        .font(.largeTitle)
                        .scaleEffect(punchlineSize)
                        .padding()
                        .onAppear {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.1, blendDuration: 2)) {
                                punchlineSize = 1
                                punchlineRotation = .degrees(270)
                            }
                        }
                        .onDisappear {
                            punchlineSize = 0.1
                            punchlineRotation = .zero
                            punchlineSize = 0.1
                        }
                    Text("Tap to continue")
                        .font(.caption)
                        .padding()
                    
                }
                
            }
        }
        .sheet(isPresented: $isSheetShown) {
            ResponseView(isPositive: gotPositiveFeedback)
        }
        .alert("Did you like that joke?", isPresented: $isAlertShown) {
            
            Button(role: .none) {
                print("Yay!")
                isSheetShown = true
                gotPositiveFeedback = true
            } label: {
                Text("Yes")
            }
            
            Button(role: .cancel) {
                print("Nooooooooo")
                isSheetShown = true
                gotPositiveFeedback = false
            } label: {
                Text("No")
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

