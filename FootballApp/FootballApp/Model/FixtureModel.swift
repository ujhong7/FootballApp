//
//  FixtureModel.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import Foundation

struct FixturesResponse: Decodable {
    let response: [Fixture]
}

struct Fixture: Decodable {
    let fixture: FixtureDetails
    let league: League
    let teams: Teams
    let goals: Goals
}

struct FixtureDetails: Codable {
    let id: Int
    let date: String
    let status: Status
}

struct Status: Codable {
    let long: String
}

struct League: Codable {
    let name: String
    let round: String
}

struct Teams: Decodable {
    let home: Team
    let away: Team
}

// (중복)
//struct Team: Codable {
//    let name: String
//    let logo: String
//}

struct Goals: Codable {
    let home: Int?
    let away: Int?
}

