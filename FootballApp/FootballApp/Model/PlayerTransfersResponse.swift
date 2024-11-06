//
//  PlayerTransfersResponse.swift
//  FootballApp
//
//  Created by yujaehong on 10/22/24.
//

import Foundation

// MARK: - PlayerTransfersResponse

struct PlayerTransfersResponse: Decodable {
    let response: [TransferInfo]
}

// MARK: - TransferInfo
struct TransferInfo: Codable {
    let transfers: [Transfer]
}

// MARK: - Transfer
struct Transfer: Codable {
    let date: String
    let type: String
    let teams: TransferTeams
}

// MARK: - TransferTeams
struct TransferTeams: Codable {
    let inTeam: TransferTeam
    let outTeam: TransferTeam

    enum CodingKeys: String, CodingKey {
        case inTeam = "in"
        case outTeam = "out"
    }
}

// MARK: - TransferTeam
struct TransferTeam: Codable {
    let id: Int
    let name: String
    let logo: String
}

