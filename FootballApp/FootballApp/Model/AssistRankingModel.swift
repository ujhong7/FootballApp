//
//  AssistRankingModel.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import Foundation

struct AssistRankingResponse: Codable {
    let response: [Assist]
}

struct Assist: Codable {
    let player: Player
    let statistics: [AssistStats]
}

struct AssistStats: Codable {
    let assists: Int
}

