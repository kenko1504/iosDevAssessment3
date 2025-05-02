//
//  cardView.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 2/5/2025.
//

import SwiftUI

//this is the visual representation of individual cards. 
struct CardView: View {
    let card :Card
    var body: some View {
        ZStack {
            if card.isFacingUp{
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                
                Text("\(card.number)")
                    .font(.title)
            }
            else{
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.red)
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
        .opacity(card.isMatched ? 0 : 1)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(type:"Heart", number: 5)) //default value for displaying it on this file
    }
}
