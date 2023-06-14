//
//  ChartIQCrosshairHUD+Extension.swift
//  ChartIQ
//
//  Created by user on 5/29/23.
//

import Foundation
import ChartIQ

extension ChartIQ.ChartIQCrosshairHUD {
    public func toDictionary() -> [String: Any] {
        return [
          "price" : price as Any,
          "volume" : volume as Any,
          "open" : open as Any,
          "high" : high as Any,
          "close" : close as Any,
          "low" : low as Any
        ]
    }

    public func toJSONString() -> String {
      guard let data = try? JSONSerialization.data(withJSONObject: self.toDictionary(), options: .prettyPrinted),
        let stringValue = String(data: data, encoding: .utf8) else { return "" }
      return stringValue
    }
}
