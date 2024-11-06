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
        clearPreviousStatistics()
        
        // Configure the cell with statistics
        guard let teamStatistics = fixture.statistics, let teams = fixture.teams else { return }
        
        // 홈팀과 어웨이팀의 통계를 각각 찾기
        guard let homeStats = getTeamStatistics(for: teams.home, from: teamStatistics),
              let awayStats = getTeamStatistics(for: teams.away, from: teamStatistics) else { return }
        
        // 통계 항목들을 하나씩 처리
        for (index, homeStatistic) in homeStats.enumerated() {
            let awayStatistic = awayStats[index]
            let statisticContainer = createStatisticContainer(for: homeStatistic, awayStatistic: awayStatistic)
            statisticsStackView.addArrangedSubview(statisticContainer)
        }
    }

    private func clearPreviousStatistics() {
        statisticsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }

    private func getTeamStatistics(for team: Team3?, from statistics: [TeamStatistics]) -> [Statistic]? {
        guard let team = team else { return nil }
        return statistics.first { $0.team.id == team.id }?.statistics
    }

    private func createStatisticContainer(for homeStatistic: Statistic, awayStatistic: Statistic) -> UIStackView {
        let statisticContainer = UIStackView()
        statisticContainer.axis = .horizontal
        statisticContainer.alignment = .center
        statisticContainer.distribution = .equalSpacing
        statisticContainer.spacing = 16
        statisticContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let homeValueLabel = createValueLabel(for: homeStatistic)
        let statisticLabel = createStatisticLabel(for: homeStatistic)
        let awayValueLabel = createValueLabel(for: awayStatistic)
        
        statisticContainer.addArrangedSubview(homeValueLabel)
        statisticContainer.addArrangedSubview(statisticLabel)
        statisticContainer.addArrangedSubview(awayValueLabel)
        
        return statisticContainer
    }

    private func createValueLabel(for statistic: Statistic) -> UILabel {
        let valueLabel = UILabel()
        valueLabel.font = UIFont.systemFont(ofSize: 16)
        valueLabel.textColor = .label
        valueLabel.textAlignment = .right
        valueLabel.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        let valueDescription: String
        if let value = statistic.value {
            switch value {
            case .int(let intValue):
                valueDescription = "\(intValue)"
            case .string(let stringValue):
                valueDescription = stringValue
            default:
                valueDescription = "0"
            }
        } else {
            valueDescription = "0"
        }
        valueLabel.text = valueDescription
        
        return valueLabel
    }

    private func createStatisticLabel(for statistic: Statistic) -> UILabel {
        let statisticLabel = UILabel()
        let statisticMappingKorean = StatisticsMapping.mappingKorean[statistic.type] ?? statistic.type
        statisticLabel.text = statisticMappingKorean
        statisticLabel.font = UIFont.boldSystemFont(ofSize: 16)
        statisticLabel.textColor = .label
        statisticLabel.textAlignment = .center
        
        return statisticLabel
    }

}
