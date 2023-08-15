//
//  ChartIQSignal+Extension.swift
//  chartiq_flutter_sdk
//
//  Created by user on 20.06.2023.
//

import Foundation
import ChartIQ

extension ChartIQSignal {
    public func toDictionary() -> [String: Any] {
        return [
            "study": self.study.toDictionary(),
            "joiner": self.joiner.stringValue,
            "name": self.name,
            "description": self.signalDescription as Any,
            "disabled": !self.isEnabled,
            "conditions": self.conditions.map { $0.toDictionary() }
        ]
    }
    
    public func toJsonString() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: self.toDictionary(), options: .prettyPrinted),
              let stringValue = String(data: data, encoding: .utf8) else { return "" }
        return stringValue
    }
}

extension [ChartIQSignal] {
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

extension ChartIQCondition {
    public func toDictionary() -> [String: Any] {
        return [
            "leftIndicator": self.leftIndicator,
            "rightIndicator": self.rightIndicator,
            "signalOperator": self.operator.stringValue,
            "markerOption": self.markerOptions?.toFlutterDictionary() as Any
        ]
    }
}

extension ChartIQMarkerOptions {
    public func toFlutterDictionary() -> [String: Any] {
        return [
            "type": self.markerType.stringValue,
            "color": self.color?.toHexString() as Any,
            "signalShape": self.shape.stringValue,
            "label": self.label,
            "signalSize": self.size.stringValue,
            "signalPosition": self.position.stringValue,
        ]
    }
}

extension [String: Any] {
    public func toChartIQSignal() -> ChartIQSignal? {
        var joiner: ChartIQSignalJoiner = .or
        
        switch self["joiner"] as? String {
        case "OR":
            joiner = .or
            break
        case "AND":
            joiner = .and
            break
        default: break
        }
        
        return ChartIQSignal(
            study: (self["study"] as! [String: Any]).toChartIQStudy()!,
            conditions: (self["conditions"] as! [[String: Any?]]).map { $0.toChartIQCondition() },
            joiner: joiner,
            name: self["name"] as! String,
            signalDescription: self["description"] as? String,
            isEnabled: !(self["disabled"] as? Bool ?? false)
        )
    }
}

extension [String: Any?] {
    public func toChartIQCondition() -> ChartIQCondition {
        var `operator`: ChartIQSignalOperator = .doesNotChange
        
        switch self["signalOperator"] as? String {
        case "greater_than":
            `operator` = .isGreaterThan
            break
        case "less_than":
            `operator` = .isLessThan
            break
        case "equal_to":
            `operator` = .isEqualTo
            break
        case "crosses":
            `operator` = .crosses
            break
        case "crosses_above":
            `operator` = .crossesAbove
            break
        case "crosses_below":
            `operator` = .crossesBelow
            break
        case "turns_up":
            `operator` = .turnsUp
            break
        case "turns_down":
            `operator` = .turnsDown
            break
        case "increases":
            `operator` = .increases
            break
        case "decreases":
            `operator` = .decreases
            break
        case "does_not_change":
            `operator` = .doesNotChange
            break
        default: break
        }
        
        let markerOptions = self["markerOption"] as? [String: Any?]
        
        return ChartIQCondition(
            leftIndicator: self["leftIndicator"] as! String,
            operator: `operator`,
            rightIndicator: self["rightIndicator"] as! String,
            markerOptions: markerOptions == nil ? nil : markerOptions!.toChartIQMarkerOptions()
        )
    }
    
    public func toChartIQMarkerOptions() -> ChartIQMarkerOptions {
        var markerType : ChartIQSignalMarkerType = .marker
        switch self["type"] as? String {
        case "marker":
            markerType = .marker
            break
        case "paintbar":
            markerType = .paintbar
            break
        default: break
        }
        
        var shape: ChartIQSignalShape = .circle
        switch self["signalShape"] as? String {
        case "circle":
            shape = .circle
            break
        case "square":
            shape = .square
            break
        case "diamond":
            shape = .diamond
            break
        default: break
        }
        
        var size : ChartIQSignalSize = .medium
        switch self["signalSize"] as? String {
        case "small":
            size = .small
            break
        case "medium":
            size = .medium
            break
        case "large":
            size = .large
            break
        default: break
        }
        
        var position: ChartIQSignalPosition = .aboveCandle
        switch self["signalPosition"] as? String {
            case "above_candle":
            position = .aboveCandle
            break
            case "below_candle":
            position = .belowCandle
            break
            case "on_candle":
            position = .onCandle
            break
        default: break
        }
        
        let colorString = self["color"] as? String
        
        return ChartIQMarkerOptions(
            markerType: markerType,
            color: colorString != nil ? UIColor(hexString: colorString!) : nil,
            shape: shape,
            label: self["label"] as! String,
            size: size,
            position: position
        )
    }
}

