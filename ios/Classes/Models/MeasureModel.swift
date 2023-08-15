//
//  MeasureModel.swift
//  chartiq_flutter_sdk
//
//  Created by user on 22.06.2023.
//

import Foundation

public class MeasureModel {
    let type: String = MessageType.measure.description
    public let measure: String
    
    public init(measure: String) {
        self.measure = measure
    }
    
    public func toDictionary() -> [String: Any] {
        return [
            "type": type,
            "measure": measure,
        ]
    }

    public func toJSONString() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: self.toDictionary(), options: .prettyPrinted),
              let stringValue = String(data: data, encoding: .utf8) else { return "" }
        return stringValue
    }
}
