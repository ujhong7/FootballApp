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
        statisticsStackView.axis = .vertical
        statisticsStackView.spacing = 13
        statisticsStackView.translatesAutoresizingMaskIntoConstraints = false
        
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
        clearPreviousStatistics()
        
        guard let teamStatistics = fixture.statistics, let teams = fixture.teams else { return }
        
        guard let homeStats = getTeamStatistics(for: teams.home, from: teamStatistics),
              let awayStats = getTeamStatistics(for: teams.away, from: teamStatistics) else { return }
        
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
        statisticContainer.spacing = 8
        statisticContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // 홈팀 막대와 레이블
        let homeBar = createValueBar(for: homeStatistic, comparedTo: awayStatistic)
        let homeValueLabel = createValueLabel(for: homeStatistic)
        
        // 통계명 레이블
        let statisticLabel = createStatisticLabel(for: homeStatistic)
        
        // 어웨이팀 레이블과 막대
        let awayValueLabel = createValueLabel(for: awayStatistic)
        let awayBar = createValueBar(for: awayStatistic, comparedTo: homeStatistic)
        
        // 홈팀 막대 -> 홈팀 수치 -> 항목 레이블 -> 어웨이팀 수치 -> 어웨이팀 막대 순서로 컨테이너에 추가
        statisticContainer.addArrangedSubview(homeBar)
        statisticContainer.addArrangedSubview(homeValueLabel)
        statisticContainer.addArrangedSubview(statisticLabel)
        statisticContainer.addArrangedSubview(awayValueLabel)
        statisticContainer.addArrangedSubview(awayBar)
        
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
    
    private func createValueBar(for statistic: Statistic, comparedTo otherStatistic: Statistic) -> UIView {
        let barView = UIView()
        barView.backgroundColor = .systemBlue
        barView.layer.cornerRadius = 3
        barView.translatesAutoresizingMaskIntoConstraints = false
        
        // 최대 막대 길이 설정
        let maxBarWidth: CGFloat = 100
        
        // 홈팀과 어웨이팀의 값 비교하여 상대적 너비 계산
        let value = getStatisticValue(from: statistic)
        let otherValue = getStatisticValue(from: otherStatistic)
        
        // 두 값을 기준으로 상대적인 너비 계산
        let total = value + otherValue
        let barWidth = total > 0 ? (value / total) * maxBarWidth : 0 // 값이 0인 경우 길이는 0
        
        NSLayoutConstraint.activate([
            barView.widthAnchor.constraint(equalToConstant: barWidth),
            barView.heightAnchor.constraint(equalToConstant: 8)
        ])
        
        return barView
    }
    
    private func getStatisticValue(from statistic: Statistic) -> CGFloat {
        if let statisticValue = statistic.value {
            switch statisticValue {
            case .int(let intValue):
                return CGFloat(intValue)
            case .string(let stringValue):
                return CGFloat(Double(stringValue) ?? 0)
            default:
                return 0
            }
        }
        return 0
    }
}
