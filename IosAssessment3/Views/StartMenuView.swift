//
//  StartMenuView.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 2/5/2025.
//

import SwiftUI

struct StartMenuView: View {
    @State private var selectedDifficulty = "Easy"
    let difficulties = ["Easy", "Medium", "Hard"]
    
    //variables for gamescore table
    //first three is describes the difficulties
    @State var data = ["Easy", "Medium", "Hard"] + (1...15).map { "\($0)" }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Concentration card game")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
                Text("Top 5 scores")
                displayGameScoreTable()
                HStack{
                    Text("Difficulty:")
                    Picker("Difficulty", selection:$selectedDifficulty){
                        ForEach(difficulties, id:\.self){ difficulty in
                            Text(difficulty)
                        }
                    }
                }
                Spacer()
                NavigationLink("Start Game", destination: CardGameView())
            }
        }
        .onAppear{
            updateGameScoreTable()
            
        }

    }
    
    func displayGameScoreTable() -> some View{
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(data, id: \.self) { item in
                Text("\(item)")
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
            }
        }
    }
    
    func updateGameScoreTable() {
        data[3] = "test"
    }
    
    func addGameScores(){
        
    }
}

#Preview {
    StartMenuView()
}
