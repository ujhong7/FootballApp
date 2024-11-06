//
//  PlayerTransferTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/22/24.
//

import UIKit

class PlayerTransferTableViewCell: UITableViewCell {
    
    static let identifier = "PlayerTransferTableViewCell"
    
    // UI 요소들
    private let dateLabel = UILabel()
    private let typeLabel = UILabel()
    private let inTeamLabel = UILabel()
    private let outTeamLabel = UILabel()
    private let inTeamLogo = UIImageView()
    private let outTeamLogo = UIImageView()
    private let arrowImageView = UIImageView(image: UIImage(systemName: "arrow.right.circle.fill"))
    
    // 초기화
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 설정
    private func setupUI() {
        // 라벨 및 이미지 뷰 스타일 설정
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        typeLabel.font = UIFont.systemFont(ofSize: 12)
        inTeamLabel.font = UIFont.systemFont(ofSize: 14)
        outTeamLabel.font = UIFont.systemFont(ofSize: 14)
        inTeamLabel.numberOfLines = 2
        outTeamLabel.numberOfLines = 2
        arrowImageView.tintColor = .systemGreen
        
        // UI 요소 추가
        contentView.addSubview(dateLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(inTeamLabel)
        contentView.addSubview(outTeamLabel)
        contentView.addSubview(inTeamLogo)
        contentView.addSubview(outTeamLogo)
        contentView.addSubview(arrowImageView)
        
        // 이미지 뷰 스타일 설정
        inTeamLogo.contentMode = .scaleAspectFit
        outTeamLogo.contentMode = .scaleAspectFit
    }
    
    // 제약 조건 설정
    private func setupConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        inTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        outTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        inTeamLogo.translatesAutoresizingMaskIntoConstraints = false
        outTeamLogo.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // 날짜 라벨 제약 조건
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // 이적료 라벨 제약 조건
            typeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // 아웃 팀 로고 제약 조건
            outTeamLogo.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 12),
            outTeamLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            outTeamLogo.widthAnchor.constraint(equalToConstant: 30),
            outTeamLogo.heightAnchor.constraint(equalToConstant: 30),
            
            // 아웃 팀 이름 제약 조건
            outTeamLabel.centerYAnchor.constraint(equalTo: outTeamLogo.centerYAnchor),
            outTeamLabel.leadingAnchor.constraint(equalTo: outTeamLogo.trailingAnchor, constant: 10),
            outTeamLabel.widthAnchor.constraint(equalToConstant: 80),
            
            // 화살표 이미지 제약 조건
            arrowImageView.centerYAnchor.constraint(equalTo: outTeamLogo.centerYAnchor),
            arrowImageView.leadingAnchor.constraint(equalTo: outTeamLabel.trailingAnchor, constant: 10),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20),
            
            // 인 팀 로고 제약 조건
            inTeamLogo.centerYAnchor.constraint(equalTo: outTeamLogo.centerYAnchor),
            inTeamLogo.leadingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: 20),
            inTeamLogo.widthAnchor.constraint(equalToConstant: 30),
            inTeamLogo.heightAnchor.constraint(equalToConstant: 30),
            
            // 인 팀 이름 제약 조건
            inTeamLabel.centerYAnchor.constraint(equalTo: outTeamLogo.centerYAnchor),
            inTeamLabel.leadingAnchor.constraint(equalTo: inTeamLogo.trailingAnchor, constant: 10),
            inTeamLabel.widthAnchor.constraint(equalToConstant: 80),
            
            // 셀 하단 여백을 위한 제약 조건
            inTeamLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
        
    }
    
    // 데이터 구성 메서드
    func configure(with transfer: Transfer) {
        dateLabel.text = transfer.date
        typeLabel.text = transfer.type
        inTeamLabel.text = transfer.teams.inTeam.name
        outTeamLabel.text = transfer.teams.outTeam.name
        
        // 이미지 로드 메서드 사용
        inTeamLogo.loadImage(from: transfer.teams.inTeam.logo)
        outTeamLogo.loadImage(from: transfer.teams.outTeam.logo)
    }
}

