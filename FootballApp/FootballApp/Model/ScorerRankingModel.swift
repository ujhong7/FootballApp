//
//  ScorerRankingModel.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import Foundation

struct ScorerRankingResponse: Codable {
    let response: [Scorer]
}

struct Scorer: Codable {
    let player: Player
    let statistics: [ScorerStats]
}

struct Player: Codable {
    let name: String
}

struct ScorerStats: Codable {
    let goals: Int
}

