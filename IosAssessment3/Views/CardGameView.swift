//
//  StartMenuView.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 2/5/2025.
//

import SwiftUI
import FirebaseAnalytics
//NOTE: this view is where the user play the concentration game
//user enters this view via start menu view and returns to that view when all cards are matched.
struct CardGameView: View {
    //debugging variable
    @Environment(\.dismiss) private var dismiss
    @State private var counter = 0
    @State private var isRunning = true
    @State var debugNum = 0
    @ObservedObject var gameViewModel : GameViewModel
    let columns = [GridItem(.adaptive(minimum: 60))] //each column is 60 points wide
    var body: some View {
        HStack{
            TimerView(counter: $counter, isRunning: $isRunning)
            //Text("Counter: \(counter)")
            Text("Difficulty: \(gameViewModel.currentGameMode)")
        }
        ScrollView{
            LazyVGrid(columns: columns, spacing: 10){ //spacing determines the vertical gap between cards
                
                ForEach(gameViewModel.deck){ card in
                    CardView(card: card)
                        .onTapGesture { //flips card when a card is tapped
                            gameViewModel.choose(card:card)
                            if(gameViewModel.checkGameEnded()){
                                print("Game has ended!")
                                //Pause game timer
                                isRunning = false
                                //Display score
                                
                                dismiss()
                                //NavigationLink("End Game", destination: StartMenuView())
                            }
                        }
                }
                .frame(height: 80)
                 
            }
        }
        .onAppear {
            //gameViewModel.debug()
            gameViewModel.resetContent()
            Analytics.logEvent("difficulty_selected", parameters: ["difficulty": "\(gameViewModel.currentGameMode)"])
            print("test")
        }
    }
}

#Preview {
    CardGameView(gameViewModel: GameViewModel())
}
