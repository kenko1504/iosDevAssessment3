//
//  HighScoreManager.swift
//  IosAssessment3
//
//  Created by Anthony Alexis on 12/5/2025.
//
import Foundation

struct HighScore: Codable, Identifiable, Hashable {
    let id = UUID()
    let score: Int
    let date: Date
    let difficulty: String
}

class HighScoreManager {
    static let shared = HighScoreManager()
    private let keyPrefix = "HighScores_"

    func getHighScores(for difficulty: String) -> [HighScore] {
        let key = keyPrefix + difficulty
        if let data = UserDefaults.standard.data(forKey: key),
           let scores = try? JSONDecoder().decode([HighScore].self, from: data) {
            return scores
        }
        return []
    }

    func addHighScore(score: Int, difficulty: String) {
        var scores = getHighScores(for: difficulty)
        scores.append(HighScore(score: score, date: Date(), difficulty: difficulty))
        scores.sort { $0.score < $1.score } // Lower time is better
        scores = Array(scores.prefix(6)) // Keep top 6
        if let data = try? JSONEncoder().encode(scores) {
            UserDefaults.standard.set(data, forKey: keyPrefix + difficulty)
        }
        UserDefaults.standard.set(true, forKey: "ShouldRefreshScores")
    }

    func getAllHighScores(for difficulties: [String]) -> [[String]] {
        var allScores: [[String]] = Array(repeating: [], count: 6)
        for (colIndex, difficulty) in difficulties.enumerated() {
            let scores = getHighScores(for: difficulty)
            for row in 0..<6 {
                if allScores[row].count < difficulties.count {
                    allScores[row] += Array(repeating: "—", count: difficulties.count - allScores[row].count)
                }
                if row < scores.count {
                    allScores[row][colIndex] = "\(scores[row].score)"
                }
            }
        }
        return allScores
    }
}

