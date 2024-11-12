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
        statisticsStackView.spacing = 13
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
            let statisticContainer = createStatisticContainer(for: homeStatistic, awayStatistic: awayStatistic,  homeTeam: teams.home?.name ?? "", awayTeam: teams.away?.name ?? "")
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
    
    private func createStatisticContainer(for homeStatistic: Statistic, awayStatistic: Statistic, homeTeam: String, awayTeam: String) -> UIStackView {
        let statisticContainer = UIStackView()
        statisticContainer.axis = .horizontal
        statisticContainer.alignment = .center
        statisticContainer.distribution = .fillProportionally // 비율로 요소를 채움
        statisticContainer.spacing = 16
        statisticContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // 홈 팀과 어웨이 팀의 통계값 레이블
        let homeValueLabel = createValueLabel(for: homeStatistic)
        let statisticLabel = createStatisticLabel(for: homeStatistic)
        let awayValueLabel = createValueLabel(for: awayStatistic)
        
        // 홈 팀과 어웨이 팀의 막대 그래프 (상대적 비율 계산 후 적용)
        let maxStatisticValue = getMaxStatisticValue(homeStatistic, awayStatistic)
        let homeBarView = createRelativeBarView(for: homeStatistic, maxValue: maxStatisticValue, isHome: true, teamName: homeTeam)
        let awayBarView = createRelativeBarView(for: awayStatistic, maxValue: maxStatisticValue, isHome: false, teamName: awayTeam)
        
        // UIStackView에 순서대로 추가
        statisticContainer.addArrangedSubview(homeValueLabel)
        statisticContainer.addArrangedSubview(homeBarView)
        statisticContainer.addArrangedSubview(statisticLabel) // statisticLabel은 고정된 너비로 설정됨
        statisticContainer.addArrangedSubview(awayBarView)
        statisticContainer.addArrangedSubview(awayValueLabel)
        
        return statisticContainer
    }
    
    private func getMaxStatisticValue(_ homeStatistic: Statistic, _ awayStatistic: Statistic) -> CGFloat {
        return max(getStatisticValue(for: homeStatistic), getStatisticValue(for: awayStatistic))
    }
    
    private func getStatisticValue(for statistic: Statistic) -> CGFloat {
        guard let value = statistic.value else { return 0 }
        
        switch value {
        case .int(let intValue):
            return CGFloat(intValue)
        case .string(let stringValue):
            if stringValue.contains("%") { // 퍼센트 값 처리
                let percentageValue = stringValue.replacingOccurrences(of: "%", with: "")
                if let percentage = Double(percentageValue) {
                    return CGFloat(percentage / 100) // 퍼센트 값을 0-1 사이로 변환
                }
            }
            if let numericValue = Double(stringValue) {
                return CGFloat(numericValue)
            }
            return 0
        default:
            return 0
        }
    }
    
    
    private func createRelativeBarView(for statistic: Statistic, maxValue: CGFloat, isHome: Bool, teamName: String) -> UIView {
        let barView = UIView()
        barView.backgroundColor = .systemGray4 // 배경색을 회색으로 설정 (비어 있는 부분 표시)
        barView.layer.cornerRadius = 4 // 막대의 끝을 둥글게
        
        // 전체 막대 길이와 색칠된 부분을 나타낼 뷰 생성
        let filledBarView = UIView()
        filledBarView.backgroundColor = .systemBlue // 수치에 따른 색깔 부분
        filledBarView.layer.cornerRadius = 4
        
        // Fetch team color from TeamColors
        let teamColor = TeamColors.colors[teamName] ?? .systemBlue // Default to blue if team color is not found
        filledBarView.backgroundColor = teamColor // Apply team color
        
        // 막대 뷰에 채워진 부분 추가
        barView.addSubview(filledBarView)
        filledBarView.translatesAutoresizingMaskIntoConstraints = false
        barView.translatesAutoresizingMaskIntoConstraints = false
        
        // 수치에 따라 색칠된 너비를 계산
        let maxBarWidth: CGFloat = 70 // 전체 막대의 최대 너비 🚨
        let statisticValue = getStatisticValue(for: statistic)
        let fillRatio = maxValue > 0 ? (statisticValue / maxValue) : 0 // 상대적 비율로 설정
        
        // `isHome` 값에 따라 왼쪽 또는 오른쪽에서 채워지도록 설정
        if isHome {
            NSLayoutConstraint.activate([
                barView.widthAnchor.constraint(equalToConstant: maxBarWidth),
                barView.heightAnchor.constraint(equalToConstant: 8), // 막대 높이
                filledBarView.trailingAnchor.constraint(equalTo: barView.trailingAnchor), // 오른쪽부터 채우기
                filledBarView.topAnchor.constraint(equalTo: barView.topAnchor),
                filledBarView.bottomAnchor.constraint(equalTo: barView.bottomAnchor),
                filledBarView.widthAnchor.constraint(equalTo: barView.widthAnchor, multiplier: fillRatio)
            ])
        } else {
            NSLayoutConstraint.activate([
                barView.widthAnchor.constraint(equalToConstant: maxBarWidth),
                barView.heightAnchor.constraint(equalToConstant: 8), // 막대 높이
                filledBarView.leadingAnchor.constraint(equalTo: barView.leadingAnchor), // 왼쪽부터 채우기
                filledBarView.topAnchor.constraint(equalTo: barView.topAnchor),
                filledBarView.bottomAnchor.constraint(equalTo: barView.bottomAnchor),
                filledBarView.widthAnchor.constraint(equalTo: barView.widthAnchor, multiplier: fillRatio)
            ])
        }
        
        return barView
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
        
        // 고정된 너비를 설정하여 바들의 위치가 일관되게 유지되도록 함
        statisticLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true // 예시로 120 포인트를 고정 너비로 설정
        
        return statisticLabel
    }
}
