//
//  TimerView.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 3/5/2025.
//

import SwiftUI

struct TimerView: View {
    @State private var counter = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("Time: \(counter)")
                .font(.largeTitle)
        }
        .onReceive(timer) { _ in
            counter += 1
        }
    }
}

#Preview {
    TimerView()
}
