//
//  cardView.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 2/5/2025.
//

import SwiftUI

//this is the visual representation of individual cards
struct CardView: View {
    let card :Card
    var body: some View {
        ZStack {
            if card.isFacingUp==false{
                RoundedRectangle(cornerRadius: 10).fill(Color.black)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(id:1, type:"Heart"))
    }
}
