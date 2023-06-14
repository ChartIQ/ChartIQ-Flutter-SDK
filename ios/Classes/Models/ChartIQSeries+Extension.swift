//
//  ChartIQSeries+Extension.swift
//  chartiq_flutter_sdk
//
//  Created by user on 5/30/23.
//

import Foundation
import ChartIQ

extension ChartIQ.ChartIQSeries {
    public func toDictionary() -> [String: Any] {
        return [
          "symbolName" : symbolName as Any,
          "color" : color as Any
        ]
    }

    public func toJSONString() -> String {
      guard let data = try? JSONSerialization.data(withJSONObject: self.toDictionary(), options: .prettyPrinted),
        let stringValue = String(data: data, encoding: .utf8) else { return "" }
      return stringValue
    }
}

extension [ChartIQ.ChartIQSeries] {
    public func toJSONString() -> String {
        var items: [[String: Any]] = []
        for item in self {
            items.append(item.toDictionary())
        }
        guard let data = try? JSONSerialization.data(withJSONObject: items, options: .prettyPrinted),
          let stringValue = String(data: data, encoding: .utf8) else { return "[]" }
        return stringValue
    }
}
