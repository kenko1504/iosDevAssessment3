import SwiftUI
//  CardModel.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 2/5/2025.
//
struct Card: Identifiable{
    let id = UUID() //unique idenfier for each card, must be mentioned for Identifiable protocol
    let type: String //Spade, Clover, Heart, Diamond
    var number: Int //number representing the card e.g, 1-13
    let height: Int = 150 //card dimensions
    let width: Int = 100
    
    var isFacingUp: Bool = false //boolean variable to track state
    var isMatched: Bool = false
}
