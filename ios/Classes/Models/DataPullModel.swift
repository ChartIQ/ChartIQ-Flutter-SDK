//
//  DataPullModel.swift
//  ChartIQ
//
//  Created by user on 5/11/23.
//

import Foundation
import ChartIQ

class DataPullModel {
    public var type: String
    public var params: ChartIQ.ChartIQQuoteFeedParams?

    public init(type: MessageType, params: ChartIQ.ChartIQQuoteFeedParams?) {
        self.type = type.description
      self.params = params
    }

    public func toDictionary() -> [String: Any] {
      return [
        "type": type as Any,
        "params": params?.toDictionary() as Any
      ]
    }

    public func toJSONString() -> String {
      guard let data = try? JSONSerialization.data(withJSONObject: self.toDictionary(), options: .prettyPrinted),
        let stringValue = String(data: data, encoding: .utf8) else { return "" }
      return stringValue
    }
}

extension ChartIQ.ChartIQQuoteFeedParams {
    public func toDictionary() -> [String: Any] {
        return [
          "symbol" : symbol as Any,
          "startDate" : startDate as Any,
          "endDate" : endDate as Any,
          "interval" : interval as Any,
          "period" : period as Any
        ]
    }
}
