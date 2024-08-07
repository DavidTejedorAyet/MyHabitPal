//
//  DictionaryExtension.swift
//  MyHabitPal
//
//

import Foundation

extension Dictionary {
    var prettyPrinted: String {
        do {
            guard JSONSerialization.isValidJSONObject(self) else {
                return ""
            }
            let data: Data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
}
