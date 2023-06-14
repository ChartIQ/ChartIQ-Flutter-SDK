//
//  ChartIQStudy+Extension.swift
//  chartiq_flutter_sdk
//
//  Created by user on 5/31/23.
//

import Foundation
import ChartIQ

extension ChartIQ.ChartIQStudy {
    public func toDictionary() -> [String: Any?] {
        return [
          "name" : name as Any,
          "attributes" : [:] as [String: Any],
          "nameParams" : nameParams as Any,
          "shortName" : shortName as Any,
          "centerLine" : 0.0 as Double,
          "customRemoval" : false,
          "deferUpdate" : false,
          "display" : fullName.isEmpty ? nil : fullName,
          "type" : false,
          "overlay" : false,
          "underlay" : false,
          "yAxis" : nil,
          "signalIQExclude" : signalIQExclude,
          "inputs" : inputs,
          "outputs" : outputs,
          "parameters" : parameters
        ]
    }

    public func toJSONString() -> String {
      guard let data = try? JSONSerialization.data(withJSONObject: self.toDictionary(), options: .prettyPrinted),
        let stringValue = String(data: data, encoding: .utf8) else { return "" }
      return stringValue
    }
}

extension [ChartIQ.ChartIQStudy] {
    public func toJSONString() -> String {
        var items: [[String: Any?]] = []
        for item in self {
            items.append(item.toDictionary())
        }
        guard let data = try? JSONSerialization.data(withJSONObject: items, options: .prettyPrinted),
          let stringValue = String(data: data, encoding: .utf8) else { return "[]" }
        return stringValue
    }
}
