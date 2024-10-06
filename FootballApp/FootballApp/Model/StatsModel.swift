//
//  StatsModel.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import Foundation

struct StatsResponse: Codable {
    let response: [Stats]
}

struct Stats: Codable {
    let team: TeamInfo
    let statistics: [StatDetails]
}

struct StatDetails: Codable {
    let type: String
    let value: Int?
}

