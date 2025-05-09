//
//  TimerView.swift
//  IosAssessment3
//
//  Created by Kenji Watanabe on 3/5/2025.
//

import SwiftUI
import FirebaseDatabase

struct SettingView: View {
    // Reference to the Firebase Realtime Database
    var ref: DatabaseReference!
    
    init() {
        // Initialize Firebase Database reference
        ref = Database.database().reference()
    }

    var body: some View {
        VStack {
            Text("Setting View")
                .onAppear {
                    // Call function to add a random value to Firebase on view load
                    addRandomValueToFirebase()
                }
        }
    }

    // Function to add a random value to Firebase Realtime Database
    func addRandomValueToFirebase() {
        // Generate a random integer
        let randomValue = Int.random(in: 1...100)
        
        // Set a random value in Firebase Database under "randomData"
        ref.child("randomData").setValue(["randomValue": randomValue]) { error, _ in
            if let error = error {
                print("Error saving data to Firebase: \(error.localizedDescription)")
            } else {
                print("Successfully saved random value: \(randomValue) to Firebase!")
            }
        }
    }
}

#Preview {
    SettingView()
}
