//
//  SquadResponse.swift
//  FootballApp
//
//  Created by yujaehong on 11/1/24.
//

import Foundation

// MARK: - SquadResponse
struct SquadResponse: Decodable {
//    let get: String
//    let parameters: Parameters
//    let errors: [String]
//    let results: Int
//    let paging: Paging
    let response: [TeamResponse]
}

//// MARK: - Parameters
//struct Parameters: Codable {
//    let team: String
//}

// MARK: - Paging
//struct Paging: Codable {
//    let current: Int
//    let total: Int
//}

// MARK: - TeamResponse
struct TeamResponse: Decodable {
    let team: Team
    let players: [Player3]
}

// MARK: - Team
//struct Team: Codable {
//    let id: Int
//    let name: String
//    let logo: String
//}

// MARK: - Player
struct Player3: Codable {
    let id: Int
    let name: String
    let age: Int
    let number: Int?
    let position: String
    let photo: String
}
