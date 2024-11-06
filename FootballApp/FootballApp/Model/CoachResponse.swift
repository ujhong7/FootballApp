//
//  CoachResponse.swift
//  FootballApp
//
//  Created by yujaehong on 11/1/24.
//

import Foundation

// MARK: - CoachResponse
struct CoachResponse: Decodable {
    let response: [CoachInfo]
}

// MARK: - Coach
struct CoachInfo: Decodable {
    let id: Int
    let name: String
    let firstname: String
    let lastname: String
    let age: Int
    let birth: Birth
    let nationality: String
    let height: String?
    let weight: String?
    let photo: String
    let team: Team
    let career: [Career]
}

// MARK: - Career
struct Career: Decodable {
    let team: Team
    let start: String
    let end: String?
}
