//
//  FixtureNetwork.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import Foundation

final class FixtureNetwork {
    
    private let networkProvider = NetworkProvider()
    
    // 경기결과 가져오기
    func getPastFixtures(league: String, season: String, completion: @escaping (Result<FixturesResponse, Error>) -> Void) {
        let path = "/fixtures"
        let parameters = [
            "league": league,
            "season": season,
            "status": "FT"  // Finished (종료된 경기)
        ]
        networkProvider.fetchData(path: path, parameters: parameters, completion: completion)
    }
    
    // 예정된 경기 가져오기
    func getUpcomingFixtures(league: String, season: String, completion: @escaping (Result<FixturesResponse, Error>) -> Void) {
        let path = "/fixtures"
        let parameters = [
            "league": league,
            "season": season,
            "status": "NS"  // Not started (예정된 경기)
        ]
        networkProvider.fetchData(path: path, parameters: parameters, completion: completion)
    }
    
    // 경기 라인업 가져오기
    func getLineups(fixtureID: String, completion: @escaping (Result<LineupResponse, Error>) -> Void) {
        let path = "/fixtures/lineups"
        let parameters = ["fixture": fixtureID]
        networkProvider.fetchData(path: path, parameters: parameters, completion: completion)
    }
    
    // 경기 기록 가져오기
    func getStats(fixtureID: String, completion: @escaping (Result<StatsResponse, Error>) -> Void) {
        let path = "/fixtures/statistics"
        let parameters = ["fixture": fixtureID]
        networkProvider.fetchData(path: path, parameters: parameters, completion: completion)
    }
}

