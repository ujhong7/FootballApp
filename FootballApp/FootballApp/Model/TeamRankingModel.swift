//
//  TeamRankingModel.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import Foundation

struct TeamRankingResponse: Codable {
    let response: [TeamRanking]
}

struct TeamRanking: Codable {
    let rank: Int
    let team: TeamDetails
    let points: Int
}

struct TeamDetails: Codable {
    let name: String
}
