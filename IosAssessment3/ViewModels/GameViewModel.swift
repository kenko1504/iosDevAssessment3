import SwiftUI
//
//  gameViewModel.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 2/5/2025.
//

//this view model is responsible for managing the cards displayed on the screen
class GameViewModel: ObservableObject {
    @Published var deck: [Card] = []
    @Published var gameMode: String = "Easy"
    
    init() {
        fillDeckWithCards()
        deck.shuffle()
        debug()
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
    
    func resetContent() {
        deck.removeAll()
        fillDeckWithCards()
        deck.shuffle()
    }
    
    func choose(card:Card){
        
        
        //gets the index of the selected card in the deck e.g., if 5 of Spade was clicked, chosenIndex=6 where 6 represents the position of that card in the deck
        guard let chosenIndex = deck.firstIndex(where: { $0.id == card.id}), !deck[chosenIndex].isFacingUp, !deck[chosenIndex].isMatched
        else {
            return
        }
        
        deck[chosenIndex].isFacingUp = true
        for index in deck.indices {
            if deck[chosenIndex].number == deck[index].number &&
                deck[index].isFacingUp &&
                deck[chosenIndex].type != deck[index].type && deck[index].hasDisappeared == false{
                
                deck[chosenIndex].isMatched = true
                deck[index].isMatched = true
                
                deck[chosenIndex].hasDisappeared = true
                deck[index].hasDisappeared = true
            }
        }
        
        //count how many cards in deck have been flipped that has not disappeared.
        var flippedCards = 0
        for index in deck.indices {
            if deck[index].isFacingUp == true && !deck[index].hasDisappeared{
                flippedCards += 1
            }
        }
        if flippedCards == 3 {
            for index in deck.indices {
                deck[index].isFacingUp = false
                
            }
            deck[chosenIndex].isFacingUp = true
        }
            
    }
    
    func debug() {
        print(deck.count)
        for i in deck{
            print("number:\(i.number), type:\(i.type)")
        }
    }
}

