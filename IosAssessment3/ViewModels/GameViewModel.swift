import SwiftUI
//
//  gameViewModel.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 2/5/2025.
//
class GameViewModel: ObservableObject {
    @Published var deck: [Card] = []
    
    init() {
        fillDeckWithCards()
        deck.shuffle()
    }
    
    //this fills the deck with 52 cards
    func fillDeckWithCards() {
        let suits = ["Spade", "Heart", "Diamond", "Clover"]
        var deck: [Card] = []

        for id in 1...13 {
            for suit in suits {
                deck.append(Card(id: id, type: suit))
            }
        }
        return
    }
}
