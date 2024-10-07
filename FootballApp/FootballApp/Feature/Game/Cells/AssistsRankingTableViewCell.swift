//
//  AssistsRankingTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import UIKit

class AssistsRankingTableViewCell: UITableViewCell {

    // UI 요소들 선언
    let rankLabel = UILabel()
    let playerImageView = UIImageView()
    let playerNameLabel = UILabel()
    let teamLogoImageView = UIImageView()
    let matchesLabel = UILabel() // 경기 수를 표시할 UILabel
    let assistsLabel = UILabel()   // 도움 수를 표시할 UILabel
    
    // 셀의 Identifier
    static let identifier = "AssistsRankingTableViewCell"
    
    // 셀 초기화 메서드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // UI 요소 설정 및 레이아웃 설정
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // UI 요소 레이아웃 설정
    private func configureUI() {
        
        playerImageView.contentMode = .scaleAspectFill
        playerImageView.clipsToBounds = true
        playerImageView.layer.cornerRadius = 20
        
        teamLogoImageView.contentMode = .scaleAspectFit
        teamLogoImageView.clipsToBounds = true
        
        // UI 요소들을 셀에 추가
        contentView.addSubview(rankLabel)
        contentView.addSubview(playerImageView)
        contentView.addSubview(playerNameLabel)
        contentView.addSubview(teamLogoImageView)
        contentView.addSubview(matchesLabel)
        contentView.addSubview(assistsLabel)
        
        // 레이아웃 설정
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        playerImageView.translatesAutoresizingMaskIntoConstraints = false
        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        teamLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        matchesLabel.translatesAutoresizingMaskIntoConstraints = false
        assistsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // 순위 레이블 위치 설정
            rankLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            rankLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // 선수 얼굴 사진 위치 설정
            playerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
            playerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playerImageView.widthAnchor.constraint(equalToConstant: 40),
            playerImageView.heightAnchor.constraint(equalToConstant: 40),
            
            // 선수 이름 레이블 위치 설정
            playerNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            playerNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // 소속 팀 로고 위치 설정
            teamLogoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 235),
            teamLogoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            teamLogoImageView.widthAnchor.constraint(equalToConstant: 40),
            teamLogoImageView.heightAnchor.constraint(equalToConstant: 40),
            
            // 경기 수 레이블 위치 설정
            matchesLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80),
            matchesLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // 골 수 레이블 위치 설정
            assistsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            assistsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    // 데이터를 설정하는 메서드
    func configure(with playerRanking: PlayerRanking, rank: Int) {
        rankLabel.text = "\(rank)"
        playerNameLabel.text = playerRanking.player.name
        matchesLabel.text = "\(playerRanking.statistics.first?.games.appearences ?? 0)"
        assistsLabel.text = "\(playerRanking.statistics.first?.goals.assists ?? 0)"
        
        // 이미지 로딩
        teamLogoImageView.loadImage(from: playerRanking.statistics.first?.team.logo ?? "")
        playerImageView.loadImage(from: playerRanking.player.photo)
    }
}
