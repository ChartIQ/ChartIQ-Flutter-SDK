//
//  MessageType.swift
//  ChartIQ
//
//  Created by user on 5/11/23.
//

import Foundation

enum MessageType: CustomStringConvertible {
    case pullInitialData
    case pullUpdateData
    case pullPaginationData
    case chartAvailable
    case chartReady
    case measure

    var description: String {
        switch self {
        case .pullInitialData: return "pullInitialData"
        case .pullUpdateData: return "pullUpdateData"
        case .pullPaginationData: return "pullPaginationData"
        case .chartAvailable: return "chartAvailable"
        case .chartReady: return "chartReady"
        case .measure: return "measure"
        }
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }

    func toJSON(_ encoder: JSONEncoder = JSONEncoder()) -> NSString {
        guard let data = try? encoder.encode(self) else { return "" }
        let result = String(decoding: data, as: UTF8.self)
        return NSString(string: result)
    }
}
