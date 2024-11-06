//
//  FixtureModel2.swift
//  FootballApp
//
//  Created by yujaehong on 10/25/24.
//

import Foundation

struct FixturesResponse: Decodable {
    let response: [Fixture]
}

struct Fixture: Decodable {
    let fixture: FixtureDetails
    let league: League
    let teams: Teams?
    let goals: Goals
    let score: Score // 추가된 필드
    let events: [Event]? // 추가된 필드
    let lineups: [Lineup]? // 추가된 필드
    let statistics: [TeamStatistics]? // 추가된 필드
    let players: [TeamPlayers]? // 추가된 필드
}

struct FixtureDetails: Codable {
    let id: Int
    let referee: String?
    let timezone: String
    let date: String
    let timestamp: Int
    let periods: Periods
    let venue: Venue2?
    let status: Status
}

struct Venue2: Codable {
    let id: Int?
    let name: String?
    let city: String?
}

struct League: Codable {
    let name: String
    let season: Int
    let round: String
}

struct Periods: Codable {
    let first: Int?
    let second: Int?
}

struct Status: Codable {
    let long: String
    let short: String
    let elapsed: Int?
    let extra: Int?
}

struct Teams: Decodable {
    let home: Team3?
    let away: Team3?
}

struct Team3: Decodable {
    let id: Int
    let name: String
    let logo: String
    let winner: Bool?
}

struct Goals: Codable {
    let home: Int?
    let away: Int?
}

// MARK: - 추가된 구조체들

struct Score: Codable {
    let halftime: HalftimeScore
    let fulltime: FulltimeScore
    let extratime: ExtraTimeScore?
    let penalty: PenaltyScore?
}

struct HalftimeScore: Codable {
    let home: Int?
    let away: Int?
}

struct FulltimeScore: Codable {
    let home: Int?
    let away: Int?
}

struct ExtraTimeScore: Codable {
    let home: Int?
    let away: Int?
}

struct PenaltyScore: Codable {
    let home: Int?
    let away: Int?
}

struct Event: Codable {
    let time: EventTime
    let team: EventTeam
    let player: EventPlayer
    let assist: EventPlayer?
    let type: String
    let detail: String
    let comments: String?
}

struct EventTime: Codable {
    let elapsed: Int
    let extra: Int?
}

struct EventTeam: Codable {
    let id: Int
    let name: String
    let logo: String
}

struct EventPlayer: Codable {
    let id: Int?
    let name: String?
}

struct Lineup: Decodable {
    let team: Team
    let coach: Coach
    let formation: String
    let startXI: [StartingPlayer]?
    let substitutes: [SubstitutePlayer]
}

struct Coach: Codable {
    let id: Int
    let name: String
    let photo: String
}

struct StartingPlayer: Codable {
    let player: Player?
}

struct SubstitutePlayer: Codable {
    let player: Player
}

struct TeamStatistics: Decodable {
    let team: Team
    let statistics: [Statistic]
}

//struct Statistic: Codable {
//    let type: String
//    let value: String?
//}

struct Statistic: Codable {
    let type: String
    let value: ValueType?
    
    enum ValueType: Codable {
        case int(Int)
        case string(String)
        case none

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let intValue = try? container.decode(Int.self) {
                self = .int(intValue)
            } else if let stringValue = try? container.decode(String.self) {
                self = .string(stringValue)
            } else {
                self = .none
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .int(let intValue):
                try container.encode(intValue)
            case .string(let stringValue):
                try container.encode(stringValue)
            case .none:
                try container.encodeNil()
            }
        }
    }
}

struct TeamPlayers: Decodable {
    let team: Team
    let players: [PlayerStatistics2]
}

struct PlayerStatistics2: Codable {
    let player: Player
    let statistics: [PlayerStatisticDetail]
}

struct PlayerStatisticDetail: Codable {
    let games: PlayerGameInfo
    let offsides: Int?
    let shots: PlayerShots
    let goals: PlayerGoals
    let passes: PlayerPasses
    let tackles: PlayerTackles
    let duels: PlayerDuels
    let dribbles: PlayerDribbles
    let fouls: PlayerFouls
    let cards: PlayerCards
    let penalty: PlayerPenalty
}

struct PlayerGameInfo: Codable {
    let minutes: Int?
    let number: Int
    let position: String
    let rating: String?
    let captain: Bool
    let substitute: Bool
}

struct PlayerShots: Codable {
    let total: Int?
    let on: Int?
}

struct PlayerGoals: Codable {
    let total: Int?
    let conceded: Int?
    let assists: Int?
    let saves: Int?
}

struct PlayerPasses: Codable {
    let total: Int?
    let key: Int?
    let accuracy: String?
}

struct PlayerTackles: Codable {
    let total: Int?
    let blocks: Int?
    let interceptions: Int?
}

struct PlayerDuels: Codable {
    let total: Int?
    let won: Int?
}

struct PlayerDribbles: Codable {
    let attempts: Int?
    let success: Int?
    let past: Int?
}

struct PlayerFouls: Codable {
    let drawn: Int?
    let committed: Int?
}

struct PlayerCards: Codable {
    let yellow: Int
    let red: Int
}

struct PlayerPenalty: Codable {
    let won: Int?
    let committed: Int?
    let scored: Int?
    let missed: Int?
    let saved: Int?
}
