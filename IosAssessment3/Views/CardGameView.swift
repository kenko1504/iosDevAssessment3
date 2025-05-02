//
//  StartMenuView.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 2/5/2025.
//

import SwiftUI

struct CardGameView: View {
    @ObservedObject var gameViewModel = GameViewModel()
    let columns = [GridItem(.adaptive(minimum: 60))]
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns, spacing: 10){
                ForEach(gameViewModel.deck){ card in
                    CardView(card: card)
                }
            }
        }
    }
}

#Preview {
    CardGameView()
}
