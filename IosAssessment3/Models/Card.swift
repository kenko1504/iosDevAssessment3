//
//  CardModel.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 2/5/2025.
//
struct Card: Identifiable{
    let id: Int //Number of card 'e.g., 2, 5, 13 or 1'
    let type: String //Spade, Clover, Heart, Diamond
    
    let height: Int = 150 //card dimensions
    let width: Int = 100
    
    var isFacingUp: Bool = false //boolean variable to track state
    var isMatched: Bool = false
}
