//
//  LineupModel.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import Foundation

struct LineupResponse: Codable {
    let response: [Lineup]
}

struct Lineup: Codable {
    let team: TeamInfo
    let coach: Coach
    let formation: String
    let startXI: [StartingPlayer]
    let substitutes: [SubstitutePlayer]
}

struct TeamInfo: Codable {
    let id: Int
    let name: String
    let logo: String
}

struct Coach: Codable {
    let id: Int
    let name: String
}

struct StartingPlayer: Codable {
    let player: PlayerInfo
    let position: String
    let number: Int
}

struct SubstitutePlayer: Codable {
    let player: PlayerInfo
    let position: String
    let number: Int
}

struct PlayerInfo: Codable {
    let id: Int
    let name: String
    let photo: String
}

