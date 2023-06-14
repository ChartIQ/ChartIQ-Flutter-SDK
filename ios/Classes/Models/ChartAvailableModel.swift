//
//  ChartAvailableModel.swift
//  chartiq_flutter_sdk
//
//  Created by user on 5/30/23.
//

import Foundation
import ChartIQ

class ChartAvailableModel {
    public var type: String
    public var available: Bool

    public init(type: MessageType, available: Bool) {
        self.type = type.description
        self.available = available
    }

    public func toDictionary() -> [String: Any] {
      return [
        "type": type as Any,
        "available": available as Any
      ]
    }

    public func toJSONString() -> String {
      guard let data = try? JSONSerialization.data(withJSONObject: self.toDictionary(), options: .prettyPrinted),
        let stringValue = String(data: data, encoding: .utf8) else { return "" }
      return stringValue
    }
}
