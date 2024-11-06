//
//  StandingsModel.swift
//  FootballApp
//
//  Created by yujaehong on 10/7/24.
//

import Foundation

// 전체 응답을 받는 구조체
struct StandingsResponse: Decodable {
    let response: [LeagueResponse]
}

// 리그 정보와 팀 순위 정보를 포함한 구조체
struct LeagueResponse: Decodable {
    let league: LeagueInfo
}

// 리그 정보를 담은 구조체
struct LeagueInfo: Decodable {
    let id: Int
    let name: String
    let country: String
    let logo: String
    let flag: String
    let season: Int
    let standings: [[TeamStats]]?
}

// 팀의 순위 정보를 담은 구조체
struct TeamStats: Decodable {
    let rank: Int                // 순위
    let team: Team               // 팀 정보
    let points: Int              // 승점
    let goalsDiff: Int           // 득실차
    let all: TeamRecord          // 전체 경기 기록
}

// 팀 정보를 담은 구조체
struct Team: Decodable {
    let id: Int
    let name: String             // 팀 이름
    let logo: String             // 팀 로고
    let winner: Bool?
}

// 팀의 경기 기록을 담은 구조체
struct TeamRecord: Decodable {
    let played: Int              // 경기 수
    let win: Int                 // 승리 수
    let draw: Int                // 무승부 수
    let lose: Int                // 패배 수
    let goals: TeamGoals         // 득점과 실점 정보
}

// 득점과 실점 정보를 담은 구조체
struct TeamGoals: Decodable {
    let forGoals: Int            // 득점 (API의 "for" 필드를 "forGoals"로 변경)
    let against: Int             // 실점
    
    enum CodingKeys: String, CodingKey {
        case forGoals = "for"
        case against
    }
}
