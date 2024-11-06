//
//  SquadResponse.swift
//  FootballApp
//
//  Created by yujaehong on 11/1/24.
//

import Foundation

// MARK: - SquadResponse
struct SquadResponse: Decodable {
    let response: [TeamResponse]
}

// MARK: - TeamResponse
struct TeamResponse: Decodable {
    let team: Team
    let players: [Player]
}

// MARK: - Player
struct Player: Codable {
    let id: Int
    let name: String
    let age: Int
    let number: Int?
    let position: String
    let photo: String
}
