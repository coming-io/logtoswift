//
//  File.swift
//
//
//  Created by Gao Sun on 2022/11/6.
//

import Foundation

public enum JsonValue: Codable, Equatable {
    case string(String)
    case number(Double)
    case bool(Bool)
    case array([JsonValue])
    case object(JsonObject)
}

public typealias JsonObject = [String: JsonValue]

extension JsonValue {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let number = try? container.decode(Double.self) {
            self = .number(number)
        } else if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
        } else if let array = try? container.decode([JsonValue].self) {
            self = .array(array)
        } else if let object = try? container.decode([String: JsonValue].self) {
            self = .object(object)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid JsonValue")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .number(let value):
            try container.encode(value)
        case .bool(let value):
            try container.encode(value)
        case .array(let value):
            try container.encode(value)
        case .object(let value):
            try container.encode(value)
        }
    }
    
