//
//  CardModel.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 2/5/2025.
//
struct Card: Identifiable{
    let id: Int //Number of card 'e.g., 2, 5, 13 or 1'
    let type: String //Spade, Clover, Heart, Diamond
    var isFacingUp: Bool = false
    var isMatched: Bool = false
}
