//
//  StringExtension.swift
//  MO2OTemplateSwift
//
//  Created by Alberto Garcia on 06/02/2017.
//  Copyright © 2017 mo2o. All rights reserved.
//

import Foundation
import SwiftUI

extension String {
    var length: Int {
        self.count
    }

    var localized: String {
        var localizedString = NSLocalizedString(self, comment: "")
        localizedString = localizedString.replacingOccurrences(of: "%s", with: "%@")
        localizedString = localizedString.replacingOccurrences(of: "%1$s", with: "%@")
        localizedString = localizedString.replacingOccurrences(of: "%2$s", with: "%@")
        localizedString = localizedString.replacingOccurrences(of: "%3$s", with: "%@")
        localizedString = localizedString.replacingOccurrences(of: "%4$s", with: "%@")
        return localizedString
    }

    var localizedFormat: String {
        let localizedString = self.localizedByReplacingOccurrences(of: "%s", with: "%@")
        return localizedString
    }

    var doubleValue: Double {
        Double(self) ?? 0
    }

    var decoded: String {
        let data = self.data(using: .utf8)
        let message = String(data: data!, encoding: .nonLossyASCII) ?? self
        return message
    }

	var getHostName: String {
		let pattern = "(?i)https?://(?:www\\.)?([\\w.-]+)"

		do {
			let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
			let range = NSRange(self.startIndex..<self.endIndex, in: self)

			if let match = regex.firstMatch(in: self, options: [], range: range) {
				let hostRange = match.range(at: 1)
				if let swiftRange = Range(hostRange, in: self) {
					return String(self[swiftRange])
				}
			}
		} catch {
			Log.info("Error al ejecutar la expresión regular: \(error)")
		}

		return ""
	}

	var isValidURL: Bool {
		let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
		if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
			// it is a link, if the match covers the whole string
			return match.range.length == self.utf16.count
		} else {
			return false
		}
	}

    static func className(aClass: AnyClass) -> String {
        NSStringFromClass(aClass).components(separatedBy: ".").last!
    }

    static func validateText(text: String?, pattern: String) -> Bool {
        guard let evaluatingText = text else { return false }
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return true }
        let range = NSRange(location: 0, length: evaluatingText.length)
        let matchRange = regex.rangeOfFirstMatch(in: evaluatingText, options: .reportProgress, range: range)
        let valid = matchRange.location != NSNotFound

        return valid
    }

    func substring(from: Int) -> String {
        String(suffix(from: startIndex))
    }

    func localizedByReplacingOccurrences(
        of target: String,
        with replacement: String,
        options: NSString.CompareOptions = [],
        range searchRange: Range<String.Index>? = nil
        ) -> String {
        self
            .localized
            .replacingOccurrences(
                of: target,
                with: replacement,
                options: options,
                range: searchRange
            )
    }

    func stringByTrimmingLeadingAndTrailingWhitespace() -> String {
        let leadingAndTrailingWhitespacePattern = "^\\s+([^\\s]*)\\s+$"
        let regex = try! NSRegularExpression(pattern: leadingAndTrailingWhitespacePattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: self.length)
        let trimmedString = regex.stringByReplacingMatches(in: self, options: .reportProgress, range: range, withTemplate: "$1")
        return trimmedString
    }
}
