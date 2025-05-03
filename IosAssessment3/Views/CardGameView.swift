//
//  StartMenuView.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 2/5/2025.
//

import SwiftUI

//NOTE: this view is where the user play the concentration game
//user enters this view via start menu view and returns to that view when all cards are matched.
struct CardGameView: View {
    //debugging variable
    @State var debugNum = 0
    
    @ObservedObject var gameViewModel = GameViewModel()
    let columns = [GridItem(.adaptive(minimum: 60))] //each column is 60 points wide
    var body: some View {
        TimerView()
        ScrollView{
            LazyVGrid(columns: columns, spacing: 10){ //spacing determines the vertical gap between cards
                
                ForEach(gameViewModel.deck){ card in
                    CardView(card: card)
                        .onTapGesture { //flips card when a card is tapped
                            gameViewModel.choose(card:card)
                        }
                }
                .frame(height: 80)
            }
        }
        .onAppear {
            //gameViewModel.debug()
            gameViewModel.resetContent()
        }
    }
}

#Preview {
    CardGameView()
}
