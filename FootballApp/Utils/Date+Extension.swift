//
//  Date+Extension.swift
//  FootballApp
//
//  Created by yujaehong on 10/31/24.
//

import Foundation

import Foundation

extension Date {
    // ISO 8601 형식의 문자열을 Date로 변환
    static func fromISO8601(_ isoDateString: String) -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        return isoFormatter.date(from: isoDateString)
    }

    // 한국 시간으로 포맷
    func toKoreanDateString() -> String {
        let koreanDateFormatter = DateFormatter()
        koreanDateFormatter.locale = Locale(identifier: "ko_KR") // 한국어 로케일 설정
        koreanDateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul") // 한국 시간대 설정
        koreanDateFormatter.dateFormat = "yyyy년 MM월 dd일 HH:mm" // 원하는 날짜 형식 설정
        return koreanDateFormatter.string(from: self)
    }
}
