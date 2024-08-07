//
//  Validator.swift
//  athletic-club-socios
//
//  Created by Alberto García on 29/10/2018.
//  Copyright © 2018 mo2o. All rights reserved.
//

import Foundation

typealias CustomValidator = ((String?) -> (result: Bool, errorMessage: String?))?
typealias PatternValidator = (() -> (pattern: String?, errorMessage: String?))?
typealias DateValidator = (Date) -> Bool

class Validator: NSObject {
    static let upperCaseRegex = ".*[A-Z]+.*"
    static let lowerCaseRegex = ".*[a-z]+.*"
    static let numbersRegex = ".*[0-9]+.*"
	static let specialChar = "^(?=.*[!¡¿ @#$%^&*(),.?\":{}|<>]).*$"
    static let passwordLenght = minMaxCharsRegex(5, 12)
	static let passwordRegex =  "^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*(),.?\":{}|<>¡¿]).{5,12}$"
    static let notEmpty = minMaxCharsRegex(1)
    static let emailRegex = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" +
    "\\@" +
    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
    "(" +
    "\\." +
    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
    ")+"

    static let emailValidator: PatternValidator = { (pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", errorMessage: "error.validation.email".localized) }

    static let passwordValidator: CustomValidator = { text in
        let upperCase = String.validateText(text: text!, pattern: upperCaseRegex)
        let lowerCase = String.validateText(text: text!, pattern: lowerCaseRegex)
        let lenghtCase = String.validateText(text: text!, pattern: passwordLenght)

        if upperCase && lowerCase && lenghtCase {
            return (true, nil)
        } else {
            return (false, "error.validation.password".localized)
        }
    }

    static let dniValidator: CustomValidator = { text in
        guard let value = text else {
            return (false, nil)
        }
        let result: Bool = (Validator.validateDNI(candidateDNI: value))
        let message: String? = (result) ? nil : "error.validation.dni".localized

        return (result, message)
    }

    // starts with 6, 7 or 9, and it has 9 digits
    static let phoneValidator: PatternValidator = { (pattern: "\\b[9|6|7][0-9]{8}\\b", errorMessage: "user.error.phoneFormat".localized) }

    static let emptyFieldValidator: PatternValidator = { (nil, nil) }

    static let minimumAgeValidator: DateValidator = { date in
        let gregorian = Calendar(identifier: .gregorian)
        let ageComponents = gregorian.dateComponents([.year], from: date, to: Date())
        let age = ageComponents.year!

        return age >= 18
    }

    static let expeditionDateValidator: DateValidator = { date in
        let today = Date()
        return !date.isGreaterThanDate(dateToCompare: today)
    }

    // 5 digits, prefix between 01-52
    static let postalCodeValidator: CustomValidator = { text in
        guard let value = text else {
            return (false, nil)
        }

        if !String.validateText(text: value, pattern: "\\b[0-9]{5}\\b") {
            return (false, "error.postalcode".localized)
        }
        let index = value.index(value.startIndex, offsetBy: 2)
        let prefix = Int(value.prefix(upTo: index))
        if prefix! < 1 || prefix! > 52 {
            return (false, "error.postalcode".localized)
        }

        return (true, nil)
    }

    static func minMaxCharsRegex(_ minChars: Int, _ maxChars: Int = 0) -> String {
        if maxChars == 0 {
            return "^(?=.{\(minChars),}$)"
        } else {
            return "^(?=.{\(minChars),\(maxChars)}$)"
        }
    }

    static func validateEmail(_ email: String) -> Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailPredicate.evaluate(with: email)
    }

    static func validateMrNumber(_ mrNumber: String) -> Bool {
        let mrNumberPredicate = NSPredicate(format: "SELF MATCHES %@", "^[0-9]{6,8}+([a-zA-Z]{1})?$")
        return mrNumberPredicate.evaluate(with: mrNumber)
    }

    static func validatePassword(_ password: String) -> Bool {
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,100}$")
        return passwordPredicate.evaluate(with: password)
    }

    static func onlyLettersAndNumbersValidator(_ text: String) -> Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Za-z0-9]{1,30}")
        return emailPredicate.evaluate(with: text)
    }

    static func validateRegex(_ regex: String, _ text: String) -> Bool {
        String.validateText(text: text, pattern: regex)
    }

    // Sum digits values for Int <= 100
    static func digitsSum(_ value: Int) -> Int {
        var currentResult: Int = 0
        var currentValue = value

        if currentValue <= 100 && currentValue > 10 {
            currentResult += currentValue % 10
            currentValue /= 10
            currentResult += currentValue
            return currentResult
        }

        if currentValue == 10 {
            currentResult += 1
        }

        return currentResult
    }

    /*
     * No ' ' or '-' characters
     *
     */
    static func validateDNI(candidateDNI: String) -> Bool {
        var evaluateString = candidateDNI.uppercased()
        let prefix = 9 - candidateDNI.length
        if prefix > 0 {
            for _ in 0..<prefix {
                evaluateString = "0" + evaluateString
            }
        }

        let buffer = NSMutableString(string: evaluateString)
        let opts = NSString.CompareOptions()
        let rng = NSRange(location: 0, length: 1)
        buffer.replaceOccurrences(of: "X", with: "0", options: opts, range: rng)
        buffer.replaceOccurrences(of: "Y", with: "1", options: opts, range: rng)
        buffer.replaceOccurrences(of: "Z", with: "2", options: opts, range: rng)

        if let baseNumber = Int(buffer.substring(to: 8)) {
            let letterMap1 = "TRWAGMYFPDXBNJZSQVHLCKET"
            let letterMap2 = "TRWAGMYFPDXBNJZSQVHLCKET".lowercased()

            let letterIdx = baseNumber % 23

            // Find case sensitive letter
            var expectedLetter = letterMap1[letterMap1.index(letterMap1.startIndex, offsetBy: letterIdx)]
            var providedLetter = evaluateString[evaluateString.index(before: evaluateString.endIndex)]

            if expectedLetter == providedLetter {
                return true
            } else {
                expectedLetter = letterMap2[letterMap2.index(letterMap2.startIndex, offsetBy: letterIdx)]
                providedLetter = evaluateString[evaluateString.index(before: evaluateString.endIndex)]

                return expectedLetter == providedLetter
            }
        }
        return false
    }

    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable function_body_length
    static func validateCIF(cifCandidate: String) -> Bool {
        if cifCandidate.count != 9 {
            return false
        }

        let valueCif = String(cifCandidate[cifCandidate.index(after: cifCandidate.startIndex) ..< cifCandidate.index(before: cifCandidate.endIndex)])
        var suma = 0

        var currIndex = valueCif.index(after: valueCif.startIndex)
        while currIndex < valueCif.endIndex {
            if Int(String(valueCif[currIndex..<valueCif.index(after: currIndex)])) != nil {
                suma += Int(String(valueCif[currIndex..<valueCif.index(after: currIndex)]))!
                currIndex = valueCif.index(currIndex, offsetBy: 2)
            } else {
                return false
            }
        }

        var suma2 = 0

        var currIndex2 = valueCif.startIndex
        while currIndex2 < valueCif.endIndex {
            let result = Int(String(valueCif[currIndex2..<valueCif.index(after: currIndex2)]))! * 2

            if result > 9 {
                suma2 += Self.digitsSum(result)
            } else {
                suma2 += result
            }

            if currIndex2 != valueCif.index(before: valueCif.endIndex) {
                currIndex2 = valueCif.index(currIndex2, offsetBy: 2)
            } else {
                break
            }
        }

        let totalSum = suma + suma2

        let unidadStr = "\(totalSum)"
        var unidadInt = 10 - Int(String(unidadStr[unidadStr.index(before: unidadStr.endIndex) ..< unidadStr.endIndex]))!

        let primerCaracter = cifCandidate.prefix(upTo: cifCandidate.index(after: cifCandidate.startIndex)).uppercased()
        let lastchar = cifCandidate.suffix(from: cifCandidate.index(before: cifCandidate.endIndex)).uppercased()
        var lastcharchar = lastchar[lastchar.startIndex]
        if Int(lastchar) != nil {
            // lastcharchar = String.init(stringInterpolationSegment: UnicodeScalar(64 + Int(lastchar)!))
            lastcharchar = Character.init(UnicodeScalar(64 + Int(lastchar)!)!)
        }

        if "FJKNPQRSUVW".contains(primerCaracter) {
            // let value = String.init(stringInterpolationSegment: UnicodeScalar(64+unidadInt))
            let value = Character.init(UnicodeScalar(64 + unidadInt)!)
            if value == lastcharchar {
                return true
            }
        } else if "XYZ".contains(primerCaracter) {
            // Se valida como un dni
            return Self.validateDNI(candidateDNI: cifCandidate)
        } else if "ABCDEFGHLM".contains(primerCaracter) {
            if unidadInt == 10 {
                unidadInt = 0
            }

            let unidadChar = Character.init(UnicodeScalar(64 + unidadInt)!)
            let lastSubstring = cifCandidate.suffix(from: cifCandidate.index(before: cifCandidate.endIndex))
            if "\(unidadInt)" == lastSubstring {
                return true
            }

            if unidadChar == lastSubstring[lastSubstring.startIndex] {
                return true
            }
        } else {
            return Self.validateDNI(candidateDNI: cifCandidate)
        }

        return false
    }
    // swiftlint:enable cyclomatic_complexity
    // swiftlint:enable function_body_length
}
