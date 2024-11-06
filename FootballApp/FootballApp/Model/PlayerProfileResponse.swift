//
//  PlayerProfileResponse.swift
//  FootballApp
//
//  Created by yujaehong on 10/22/24.
//

import Foundation

// MARK: - PlayerProfileResponse
struct PlayerProfileResponse: Codable {
    let response: [PlayerResponse]
}

// MARK: - PlayerResponse
struct PlayerResponse: Codable {
    let player: Player
    let statistics: [PlayerStat]?
}

// MARK: - Player
struct Player: Codable {
    let id: Int //
    let name: String //
    let pos: String?
    let firstname: String?
    let lastname: String?
    let age: Int? //
    let birth: Birth?
    let nationality: String?
    let height: String?
    let weight: String?
    let injured: Bool?
    let photo: String? //
}

// MARK: - Birth
struct Birth: Codable {
    let date: String?
    let place: String?
    let country: String?
}

// MARK: - PlayerStatistics
struct PlayerStat: Codable {
    let team: TeamDetails
    let league: LeagueDetails
    let games: GameStats
    let substitutes: Substitutes
    let shots: Shots
    let goals: GoalStats
    let passes: Passes
    let tackles: Tackles
    let duels: Duels
    let dribbles: Dribbles
    let fouls: Fouls
    let cards: Cards
    let penalty: Penalty
}

struct TeamDetails: Codable {
    let id: Int
    let name: String
    let logo: String
}

struct LeagueDetails: Codable {
    let id: Int
    let name: String
    let country: String
    let logo: String
    let flag: String
    let season: Int
}

// MARK: - Games
struct GameStats: Codable {
    let appearences: Int
    let lineups: Int
    let minutes: Int
    let number: Int?
    let position: String
    let rating: String
    let captain: Bool
}

// MARK: - Substitutes
struct Substitutes: Codable {
    let inCount: Int
    let outCount: Int
    let bench: Int
    
    enum CodingKeys: String, CodingKey {
        case inCount = "in"
        case outCount = "out"
        case bench
    }
}

// MARK: - Shots
struct Shots: Codable {
    let total: Int
    let on: Int
}

// MARK: - Goals
struct GoalStats: Codable {
    let total: Int
    let conceded: Int
    let assists: Int
    let saves: Int?
}

// MARK: - Passes
struct Passes: Codable {
    let total: Int
    let key: Int
    let accuracy: Int?
}

// MARK: - Tackles
struct Tackles: Codable {
    let total: Int
    let blocks: Int?
    let interceptions: Int
}

// MARK: - Duels
struct Duels: Codable {
    let total: Int
    let won: Int
}

// MARK: - Dribbles
struct Dribbles: Codable {
    let attempts: Int
    let success: Int
    let past: Int?
}

// MARK: - Fouls
struct Fouls: Codable {
    let drawn: Int
    let committed: Int
}

// MARK: - Cards
struct Cards: Codable {
    let yellow: Int
    let yellowred: Int
    let red: Int
}

// MARK: - Penalty
struct Penalty: Codable {
    let won: Int?
    let commited: Int?
    let scored: Int
    let missed: Int
    let saved: Int?
}
