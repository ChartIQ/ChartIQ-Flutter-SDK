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
          "fullName": fullName,
          "originalName": originalName,
          "uniqueId": uniqueId,
          "overlay" : false,
          "underlay" : false,
          "yAxis" : nil,
          "signalIQExclude" : signalIQExclude,
          "inputs" : inputs,
          "outputs" : outputs,
          "parameters" : parameters,
        ]
    }

    public func toJSONString() -> String {
      guard let data = try? JSONSerialization.data(withJSONObject: self.toDictionary(), options: .prettyPrinted),
        let stringValue = String(data: data, encoding: .utf8) else { return "" }
      return stringValue
    }
    
    public func toStudySimplified() -> ChartIQStudySimplidiedModel {
        return ChartIQStudySimplidiedModel(
            studyName: self.fullName,
            outputs: self.outputs
        )
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

extension [String: Any] {
    public func toChartIQStudy() -> ChartIQStudy? {
        if let shortName = self["shortName"] as? String,
           let fullName = self["fullName"] as? String,
           let originalName = self["originalName"] as? String {
            let study = ChartIQStudy.init(shortName: shortName,
                             fullName: fullName,
                             originalName: originalName,
                             uniqueId: "",
                             inputs: self["inputs"] as? [String: Any]? ?? nil,
                             outputs: self["outputs"] as? [String: Any]? ?? nil,
                             parameters: self["parameters"] as? [String: Any]? ?? nil,
                             signalIQExclude: self["signalIQExclude"] as? Bool ?? false
            )
            study.name = self["name"] as? String ?? ""
            study.nameParams = self["nameParams"] as? String ?? ""
            study.uniqueId = self["uniqueId"] as? String
            return study
        }
        return nil
    }
}
//
//extension Any? {
//    public func toFlutterStudyParameter() ->
//}
