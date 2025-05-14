//
//  StartMenuView.swift
//  IosAssessment3
//  Created by Kenji Watanabe on 2/5/2025.
//

import SwiftUI
import FirebaseAnalytics

struct StartMenuView: View {
    @State private var selectedDifficulty = "Easy"
    @State var difficulties: [String] = []
    @State var gameViewModel = GameViewModel()

    let header = ["Easy", "Medium", "Hard"]

    // This holds the actual high score data per row per difficulty
    @State var data: [[String]] = Array(repeating: Array(repeating: "—", count: 3), count: 6)

    var body: some View {
        NavigationStack {
            VStack {
                Text("Concentration card game")
                    .font(.title)
                Spacer()

                displayGameScoreTable()

                HStack {
                    Text("Difficulty:")
                    Picker("Difficulty", selection: $selectedDifficulty) {
                        ForEach(difficulties, id: \.self) { difficulty in
                            Text(difficulty)
                        }
                    }
                    .onChange(of: selectedDifficulty) { newDifficulty in
                        print("Selected Difficulty: \(newDifficulty)")
                        gameViewModel.modifyDifficulty(difficulty: newDifficulty)
                        print(gameViewModel.currentGameMode)
                    }
                }
                Spacer()

                NavigationLink("Start Game", destination: CardGameView(gameViewModel: gameViewModel))
                    .onTapGesture {
                        gameViewModel.resetGameEndedFlag()  // Reset game end flag when starting a new game
                    }
                Spacer()
            }
        }
        .onAppear {
            self.difficulties = gameViewModel.gameModes
            updateGameScoreTable()
        }
        // Step 3: Observe when the game ends and refresh the score table
        .onChange(of: gameViewModel.gameDidEnd) { ended in
            if ended {
                print("Game ended – updating score table")
                updateGameScoreTable() // Refresh the score table
                gameViewModel.resetGameEndedFlag()  // Reset the flag so it doesn't trigger again
            }
        }
    }

    // Display the high score table
    func displayGameScoreTable() -> some View {
        VStack {
            Text("Top 6 Time Scores (Lower is Better)")
                .font(.headline)
                .padding(.bottom, 5)

            HStack {
                ForEach(header, id: \.self) { item in
                    Text(item)
                        .frame(maxWidth: .infinity)
                        .padding(5)
                        .font(.subheadline)
                }
            }
            .padding(.horizontal, 20)

            List {
                ForEach(data, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            Text(item)
                                .frame(maxWidth: .infinity, minHeight: 35)
                                .background(Color.green.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 20)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding(.top, 30)
    }

    // Load real data from high score storage
    func updateGameScoreTable() {
        // Get the high scores from HighScoreManager
        self.data = HighScoreManager.shared.getAllHighScores(for: header)
    }
}

#Preview {
    StartMenuView()
}
