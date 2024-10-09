//
//  ScorerRankingModel.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//


import Foundation

struct PlayerRankingResponse: Decodable {
    let response: [PlayerRanking]
}

// 선수 순위 모델
struct PlayerRanking: Decodable {
    let player: PlayerInfo
    let statistics: [PlayerStatistics]
}

// 선수 정보 모델
struct PlayerInfo: Codable {
    let id: Int
    let name: String
    let firstname: String
    let lastname: String
    let nationality: String
    let age: Int
    let birth: BirthInfo
    let photo: String
}

// 출생 정보 모델
struct BirthInfo: Codable {
    let date: String
    let place: String?
    let country: String
}

// 선수 통계 모델
struct PlayerStatistics: Decodable {
    let team: TeamInfo
    let league: LeagueInfo
    let goals: GoalsInfo
    let games: Games
}

struct Games: Codable {
    let appearences: Int
}

// 팀 정보 모델
struct TeamInfo: Codable {
    let id: Int
    let name: String
    let logo: String
}

// (중복)
// 리그 정보 모델 
//struct LeagueInfo: Codable {
//    let id: Int
//    let name: String
//    let country: String
//    let logo: String
//    let flag: String
//}

// 골 수 정보 모델
struct GoalsInfo: Codable {
    let total: Int
    let assists: Int
}


