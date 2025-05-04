//
//  StartMenuView.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 2/5/2025.
//

import SwiftUI

struct StartMenuView: View {
    @State private var selectedDifficulty = "Easy"
    @State var difficulties: [String] = []
    
    @State var gameViewModel = GameViewModel()
    
    
    let header = ["Easy", "Medium", "Hard"]
    @State var data = [
        ["0", "0", "0"],
        ["0", "0", "0"],
        ["0", "0", "0"],
        ["0", "0", "0"],
        ["0", "0", "0"],
        ["0", "0", "0"]
    ]
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Concentration card game")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
                displayGameScoreTable()
                HStack{
                    Text("Difficulty:")
                    Picker("Difficulty", selection:$selectedDifficulty){
                        ForEach(difficulties, id:\.self){ difficulty in
                            Text(difficulty)
                        }
                    }
                    .onChange(of: selectedDifficulty) { newDifficulty in
                                    // Code to run whenever the picker selection changes
                        print("Selected Difficulty: \(newDifficulty)")
                        gameViewModel.modifyDifficulty(difficulty: newDifficulty)
                        print(gameViewModel.currentGameMode)
                    }
                }
                Spacer()
                NavigationLink("Start Game", destination: CardGameView(gameViewModel: gameViewModel))
                    .onTapGesture {
                        print(selectedDifficulty)
                    }
                Spacer()
            }
        }
        .onAppear{
            updateGameScoreTable()
            debug()
            self.difficulties = gameViewModel.gameModes
        }

    }
    
    //responsible for displaying score
    func displayGameScoreTable() -> some View{
        VStack{
            Text("Top 5 time scores")
            HStack {
                 ForEach(header, id: \.self) { item in
                     Text(item)
                         .frame(maxWidth: .infinity, minHeight: 10)
                         .padding(5)
                 }
             }
            .offset(y:10)
            .padding(.horizontal, 20.0)
            List(data, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { item in
                        Text(item)
                            .frame(maxWidth: .infinity, minHeight: 35)
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                .listRowInsets(EdgeInsets())
                .padding(.horizontal, 20.0)
                .listRowSeparator(.hidden)
                
            }
            .listStyle(PlainListStyle())
            
        }
        .offset(y: 100)
    }
    
    func updateGameScoreTable() {
    }
    
    func addGameScores(){
        
    }
    
    func debug(){
    }
}

#Preview {
    StartMenuView()
}
