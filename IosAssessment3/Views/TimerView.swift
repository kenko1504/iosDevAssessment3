//
//  TimerView.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 3/5/2025.
//

import SwiftUI

struct TimerView: View {
    @Binding var counter: Int
    @Binding var isRunning: Bool
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("Time: \(counter)")
        }
        .onReceive(timer) { _ in
            if(isRunning){
                counter += 1
            }
            else{
                print("COUNTER ENDED")
            }
            
        }
    }
}

#Preview {
    TimerView(counter: .constant(0), isRunning: .constant(true))
}

