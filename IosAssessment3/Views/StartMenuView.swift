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
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Concentration card game")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
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

    }
}

#Preview {
    StartMenuView()
}
