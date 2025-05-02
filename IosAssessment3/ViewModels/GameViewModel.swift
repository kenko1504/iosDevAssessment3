import SwiftUI
//
//  gameViewModel.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 2/5/2025.
//
class GameViewModel: ObservableObject {
    @Published var deck: [Card] = []
    @Published var gameMode: String = "Easy"
    
    init() {
        fillDeckWithCards()
        deck.shuffle()
    }
    
    //this fills the deck with 52 cards
    func fillDeckWithCards() {
        let suits = ["Spade", "Heart", "Diamond", "Clover"]
        for numb in 1...13 {
            for suit in suits {
                deck.append(Card(type: suit, number: numb))
            }
        }
        return
    }
    
    func debug() {
        print(deck.count)
        for i in deck{
            print("id:\(i.number), type:\(i.type)")
        }
    }
}

