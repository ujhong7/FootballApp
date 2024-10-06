//
//  RankingNetwork.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import Foundation

final class RankingNetwork {
    
    private let networkProvider = NetworkProvider()
    
    // 팀 순위 가져오기
    func getTeamRanking(league: String, season: String, completion: @escaping (Result<TeamRankingResponse, Error>) -> Void) {
        let path = "/standings"
        let parameters = ["league": league, "season": season]
        networkProvider.fetchData(path: path, parameters: parameters, completion: completion)
    }
    
    // 득점 순위 가져오기
    func getTopScorers(league: String, season: String, completion: @escaping (Result<ScorerRankingResponse, Error>) -> Void) {
        let path = "/players/topscorers"
        let parameters = ["league": league, "season": season]
        networkProvider.fetchData(path: path, parameters: parameters, completion: completion)
    }
    
    // 도움 순위 가져오기
    func getTopAssists(league: String, season: String, completion: @escaping (Result<AssistRankingResponse, Error>) -> Void) {
        let path = "/players/topassists"
        let parameters = ["league": league, "season": season]
        networkProvider.fetchData(path: path, parameters: parameters, completion: completion)
    }
}

