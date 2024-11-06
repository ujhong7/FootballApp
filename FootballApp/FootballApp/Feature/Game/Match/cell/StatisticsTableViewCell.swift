//
//  StatisticsTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/29/24.
//

import UIKit

class StatisticsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "StatisticsTableViewCell"
    
    private let statisticsStackView = UIStackView()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        // Set up the statistics stack view
        statisticsStackView.axis = .vertical
        statisticsStackView.spacing = 8
        statisticsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add stack view to the content view
        contentView.addSubview(statisticsStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            statisticsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statisticsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            statisticsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            statisticsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with fixture: Fixture) {
        // Clear previous statistics
        statisticsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Configure the cell with statistics
        guard let teamStatistics = fixture.statistics, let teams = fixture.teams else { return }
        
        // 홈팀과 어웨이팀의 통계를 각각 찾기
        let homeTeamStatistics = teamStatistics.first { $0.team.id == teams.home?.id }
        let awayTeamStatistics = teamStatistics.first { $0.team.id == teams.away?.id }
        
        // 두 팀의 통계가 모두 있어야 함
        guard let homeStats = homeTeamStatistics?.statistics, let awayStats = awayTeamStatistics?.statistics else { return }
        
        // 통계 항목들을 하나씩 처리
        for (index, homeStatistic) in homeStats.enumerated() {
            // 어웨이팀의 같은 index에서 통계 데이터를 가져옴
            let awayStatistic = awayStats[index]
            
            let statisticContainer = UIStackView()
            statisticContainer.axis = .horizontal
            statisticContainer.alignment = .center
            statisticContainer.distribution = .equalSpacing // 각 요소를 고르게 분배
            statisticContainer.spacing = 16
            statisticContainer.translatesAutoresizingMaskIntoConstraints = false
            
            let homeValueLabel = UILabel()
            homeValueLabel.font = UIFont.systemFont(ofSize: 16)
            homeValueLabel.textColor = .label
            homeValueLabel.textAlignment = .right
            
            let statisticLabel = UILabel()
            // 한글로 바꿈 ⭐️
            // statisticLabel.text = homeStatistic.type // 통계 항목 이름
            let statisticMappingKorean = StatisticsMapping.mappingKorean[homeStatistic.type] ?? homeStatistic.type
            statisticLabel.text = statisticMappingKorean
            // ⭐️
            statisticLabel.font = UIFont.boldSystemFont(ofSize: 16)
            statisticLabel.textColor = .label
            statisticLabel.textAlignment = .center
            
            let awayValueLabel = UILabel()
            awayValueLabel.font = UIFont.systemFont(ofSize: 16)
            awayValueLabel.textColor = .label
            awayValueLabel.textAlignment = .right
            
            // Label Width Constraint 설정
            homeValueLabel.widthAnchor.constraint(equalToConstant: 35).isActive = true
            awayValueLabel.widthAnchor.constraint(equalToConstant: 35).isActive = true
            
            // 홈팀 값 처리
            let homeValueDescription: String
            if let value = homeStatistic.value {
                switch value {
                case .int(let intValue):
                    homeValueDescription = "\(intValue)"
                case .string(let stringValue):
                    homeValueDescription = stringValue
                default:
                    homeValueDescription = "0"
                }
            } else {
                homeValueDescription = "0"
            }
            homeValueLabel.text = homeValueDescription
            
            // 어웨이팀 값 처리
            let awayValueDescription: String
            if let value = awayStatistic.value {
                switch value {
                case .int(let intValue):
                    awayValueDescription = "\(intValue)"
                case .string(let stringValue):
                    awayValueDescription = stringValue
                default:
                    awayValueDescription = "0"
                }
            } else {
                awayValueDescription = "0"
            }
            awayValueLabel.text = awayValueDescription
            
            statisticContainer.addArrangedSubview(homeValueLabel) // 홈팀 값
            statisticContainer.addArrangedSubview(statisticLabel) // 통계 항목 이름
            statisticContainer.addArrangedSubview(awayValueLabel) // 어웨이팀 값
            
            statisticsStackView.addArrangedSubview(statisticContainer)
        }
    }
    
}
