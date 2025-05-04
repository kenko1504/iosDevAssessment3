import SwiftUI
//
//  gameViewModel.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 2/5/2025.
//

//this view model is responsible for managing gameplay
class GameViewModel: ObservableObject {
    @Published var deck: [Card] = []
    @Published var gameModes: [String] = ["Easy", "Medium", "Hard"]
    @Published var currentGameMode: String = "Easy"
    let easyCardNumber:Int = 8
    let mediumCardNumber:Int = 20

    init() {
        fillDeckWithCards()
        deck.shuffle()
    }
    
    //this fills the deck with 52 cards
    //then generate deck of cards depending on difficulty: 8 cards for easy (but with guarenteed pairs
    //20 for medium
    //56 for hard
    func fillDeckWithCards() {
        let suits = ["Spade", "Heart", "Diamond", "Clover"]
        for numb in 1...13 {
            for suit in suits {
                deck.append(Card(type: suit, number: numb))
            }
        }
        if currentGameMode == "Easy"{
            deck = generatePairs(for: easyCardNumber)
        }
        else if currentGameMode == "Medium" {
            deck = generatePairs(for: mediumCardNumber)
        }
        else{
            //nothing; dont modify for hard since hard is 52 cards
        }
        return
    }
    
    func modifyDifficulty(difficulty: String) {
        currentGameMode = difficulty

    }
    
    //generate pairs of cards depending on difficulty. Accepts number of card for parameter (e.g., easy is 8)
    func generatePairs(for number: Int) -> [Card] {
        
        // Array to hold selected pairs
        var selectedCards: [Card] = []
        
        // Set to track which numbers we have already selected
        var selectedNumbers = Set<Int>()
        
        // Loop until we have the required number of pairs
        while selectedCards.count < number {
            // Randomly choose a number between 1 and 13
            let randomNumber = Int.random(in: 1...13)
            
            // Ensure we haven't selected this number already
            if !selectedNumbers.contains(randomNumber) {
                selectedNumbers.insert(randomNumber)
                
                // Filter the deck for cards matching the random number
                let matchingCards = deck.filter { $0.number == randomNumber }
                
                // Ensure we have at least two cards with different suits
                if matchingCards.count >= 2 {
                    // Shuffle the cards to randomize the suits
                    let shuffledCards = matchingCards.shuffled()
                    
                    // Add the first two cards to the selected list
                    selectedCards.append(shuffledCards[0])
                    selectedCards.append(shuffledCards[1])
                }
            }
        }
        
        return selectedCards
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

