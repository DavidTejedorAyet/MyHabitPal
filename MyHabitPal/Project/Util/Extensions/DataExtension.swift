//
//  DataExtension.swift
//  MyHabitPal
//
//

import Foundation

extension Data {
    var prettyPrinted: String {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return "" }

        return prettyPrintedString as String
    }
}
