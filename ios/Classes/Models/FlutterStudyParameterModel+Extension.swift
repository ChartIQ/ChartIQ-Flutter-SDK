//
//  FlutterStudyParameterModel.swift
//  chartiq_flutter_sdk
//
//  Created by user on 19.06.2023.
//

import Foundation


public class FlutterStudyParameterModel {
    public var type: String
    public var value: FlutterStudyParameterValueModel
    
    public init(type: String, value: FlutterStudyParameterValueModel) {
        self.type = type.description
        self.value = value
    }
    
    public func toDictionary() -> [String: Any] {
        return [
            "type": type,
            "value": value.toJSONString()
        ]
    }
    
    
    
    public func toJSONString() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: self.toDictionary(), options: .prettyPrinted),
              let stringValue = String(data: data, encoding: .utf8) else { return "" }
        return stringValue
    }
}

public class FlutterStudyParameterValueModel {
    public var value: Any
    public var name: String
    public var defaultInput: Any
    public var heading: String
    public var options: [String: Any]?
    
    public init(value: Any, name: String, defaultInput: Any, heading: String, options: [String: Any]?) {
        self.value = value
        self.name = name
        self.defaultInput = defaultInput
        self.heading = heading
        self.options = options
    }
    
    public func toDictionary() -> [String: Any] {
        return [
            "value": value,
            "name": name,
            "defaultValue": defaultInput,
            "heading": heading,
            "options": options,
        ]
    }

    public func toJSONString() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: self.toDictionary(), options: .prettyPrinted),
              let stringValue = String(data: data, encoding: .utf8) else { return "" }
        return stringValue
    }
}

extension [String:Any] {
    public func toFlutterStudyParameter() -> FlutterStudyParameterModel {
        if let parameter = self["color"] as? String{
            return FlutterStudyParameterModel(
                type: "color",
                value: FlutterStudyParameterValueModel(
                    value: parameter,
                    name: self["name"] as? String ?? "",
                    defaultInput: self["defaultOutput"] ?? "",
                    heading: self["heading"] as? String ?? "",
                    options: nil
                )
            )
        }
        return FlutterStudyParameterModel(
            type: self["type"] as? String ?? "unknown",
            value: FlutterStudyParameterValueModel(
                value: self["value"] ?? "",
                name: self["name"] as? String ?? "",
                defaultInput: self["defaultInput"] ?? "",
                heading: self["heading"] as? String ?? "",
                options: self["options"] as? [String : Any]
            )
        )
    }
}

extension [FlutterStudyParameterModel] {
    public func toJsonString() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: self.map {$0.toDictionary()}, options: .prettyPrinted),
              let stringValue = String(data:data, encoding: .utf8) else {return  ""}
        return stringValue
    }
}

