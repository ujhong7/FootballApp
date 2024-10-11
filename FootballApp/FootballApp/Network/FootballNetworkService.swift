//
//  FootballNetworkService.swift
//  FootballApp
//
//  Created by yujaehong on 10/11/24.
//

import Foundation

final class FootballNetworkService {
    
    private let baseURL = "https://api-football-v1.p.rapidapi.com/v3"
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "FOOTBALL_API_KEY") as? String ?? "default_value"
    private let networkProvider = NetworkProvider()
    
    // MARK: - Fixtures
    
    // 지난 경기 결과 가져오기 (Past Fixtures)
    func getPastFixtures(league: String, season: String, completion: @escaping (Result<FixturesResponse, Error>) -> Void) {
        let path = "/fixtures"
        let parameters = [
            "league": league,
            "season": season,
            "status": "FT" // FT: Full Time
        ]
        let headers = ["X-RapidAPI-Key": apiKey]
        networkProvider.request(baseURL: baseURL, path: path, headers: headers, parameters: parameters, completion: completion)
    }
    
    // 다가오는 경기 일정 가져오기 (Upcoming Fixtures)
    func getUpcomingFixtures(league: String, season: String, completion: @escaping (Result<FixturesResponse, Error>) -> Void) {
        let path = "/fixtures"
        let parameters = [
            "league": league,
            "season": season,
            "status": "NS" // NS: Not Started
        ]
        let headers = ["X-RapidAPI-Key": apiKey]
        networkProvider.request(baseURL: baseURL, path: path, headers: headers, parameters: parameters, completion: completion)
    }
    
    // MARK: - Rankings
    
    // 팀 순위 가져오기 (Team Standings)
    func getTeamRanking(league: String, season: String, completion: @escaping (Result<StandingsResponse, Error>) -> Void) {
        let path = "/standings"
        let parameters = ["league": league, "season": season]
        let headers = ["X-RapidAPI-Key": apiKey]
        networkProvider.request(baseURL: baseURL, path: path, headers: headers, parameters: parameters, completion: completion)
    }
    
    // 득점 순위 가져오기 (Top Scorers)
    func getTopScorers(league: String, season: String, completion: @escaping (Result<PlayerRankingResponse, Error>) -> Void) {
        let path = "/players/topscorers"
        let parameters = ["league": league, "season": season]
        let headers = ["X-RapidAPI-Key": apiKey]
        networkProvider.request(baseURL: baseURL, path: path, headers: headers, parameters: parameters, completion: completion)
    }
    
    // 도움 순위 가져오기 (Top Assists)
    func getTopAssists(league: String, season: String, completion: @escaping (Result<PlayerRankingResponse, Error>) -> Void) {
        let path = "/players/topassists"
        let parameters = ["league": league, "season": season]
        let headers = ["X-RapidAPI-Key": apiKey]
        networkProvider.request(baseURL: baseURL, path: path, headers: headers, parameters: parameters, completion: completion)
    }
}
