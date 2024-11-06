//
//  TeamInfoResponse.swift
//  FootballApp
//
//  Created by yujaehong on 10/19/24.
//

import Foundation

// MARK: - TeamInfoResponse
struct TeamInfoResponse: Codable {
    let response: [TeamDetail]
}

// MARK: - TeamDetail
struct TeamDetail: Codable {
    let team: TeamDetailInfo
    let venue: Venue
}

// MARK: - Team
struct TeamDetailInfo: Codable {
    let id: Int
    let name: String
    let code: String?
    let country: String
    let founded: Int?
    let national: Bool
    let logo: String
}

// MARK: - Venue
struct Venue: Codable {
    let id: Int
    let name: String
    let address: String?
    let city: String
    let capacity: Int?
    let surface: String?
    let image: String
}

