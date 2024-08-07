//
//  LogsManager.swift
//  MyHabitPal
//
//  Created by Jesmir Baloa on 6/2/23.
//

import Foundation
import OSLog

enum Log {
    enum LogLevel: String {
        case error
        case success
        case warning
        case request
        case info
        case local
        case lifecycle
        case dictionary

        fileprivate var osLogType: OSLogEntryLog.Level {
            switch self {
            case .info, .local, .lifecycle, .dictionary:    return .debug
            case .warning:                                  return .info
            case .success, .request:                        return .notice
            case .error:                                    return .error
            }
        }

        fileprivate var prefix: String {
            switch self {
            case .error:        return "❌"
            case .success:      return "✅"
            case .warning:      return "⚠️"
            case .request:      return "🌐"
            case .info:         return "✏️"
            case .local:        return "📱"
            case .lifecycle:    return "♻️"
            case .dictionary:   return "📖"
            }
        }
    }

    struct ContextLog {
        let file: String
        let function: String
        let line: Int
        var description: String {
            "[\((file as NSString).lastPathComponent):\(line)] ~~> \(function)"
        }
    }

    static func info(_ message: String,
                     shouldLogContext: Bool = true,
                     file: String = #file,
                     function: String = #function,
                     line: Int = #line) {
        let context = ContextLog(file: file, function: function, line: line)
        Self.genericLog(message, level: .info, shouldLogContext: shouldLogContext, context: context)
    }

    static func success(_ message: String,
                        shouldLogContext: Bool = true,
                        file: String = #file,
                        function: String = #function,
                        line: Int = #line) {
        let context = ContextLog(file: file, function: function, line: line)
        Self.genericLog(message, level: .success, shouldLogContext: shouldLogContext, context: context)
    }

    static func local(_ message: String,
                      shouldLogContext: Bool = true,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line) {
        let context = ContextLog(file: file, function: function, line: line)
        Self.genericLog(message, level: .local, shouldLogContext: shouldLogContext, context: context)
    }

    static func warning(_ message: String,
                        shouldLogContext: Bool = true,
                        file: String = #file,
                        function: String = #function,
                        line: Int = #line,
                        category: String? = nil) {
        let context = ContextLog(file: file, function: function, line: line)
        Self.genericLog(message, level: .warning, shouldLogContext: shouldLogContext, context: context, category: category)
    }

    static func lifecycle(_ message: String,
                          shouldLogContext: Bool = true,
                          file: String = #file,
                          function: String = #function,
                          line: Int = #line) {
        let context = ContextLog(file: file, function: function, line: line)
        Self.genericLog(message, level: .lifecycle, shouldLogContext: shouldLogContext, context: context)
    }

    static func dictionary(_ data: [String: AnyObject],
                           source: String,
                           shouldLogContext: Bool = true,
                           file: String = #file,
                           function: String = #function,
                           line: Int = #line) {
        let context = ContextLog(file: file, function: function, line: line)
        let logComponents = ["Source: ", source, "\n\n", data.prettyPrinted, "\n======"]
        Self.handleLog(level: .dictionary, logComponents: logComponents, shouldLogContext: shouldLogContext, context: context)
    }

    static func error(_ notes: String,
                      shouldLogContext: Bool = true,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line,
                      category: String? = nil) {
        let context = ContextLog(file: file, function: function, line: line)
        let logComponents = ["Notes: ", notes, "\n======"]
        Self.handleLog(level: .error, logComponents: logComponents, shouldLogContext: shouldLogContext, context: context, category: category)
    }

    static func request(_ request: URLRequest,
                        data: Data? = nil,
                        status: Int = 0,
                        activeCache: Bool = false,
                        shouldLogContext: Bool = true,
                        file: String = #file,
                        function: String = #function,
                        line: Int = #line) {
        let symbolStatus: String = (200...299).contains(status) ? "🟢" : "🔴"
        let context = ContextLog(file: file, function: function, line: line)
        let symbolActiveCache = activeCache ? "🟢" : "🔴"

        var log: String = "\n🌍 \((request.httpMethod ?? "").uppercased()): \(request.url?.absoluteString ?? "")"
        log += " || 🌐 Status: \(symbolStatus) \(status) || 💾 Cache: \(symbolActiveCache)\n\n"

        if let headers = request.allHTTPHeaderFields {
            log += ":::::: ⚙️ HEADERS ::::::\n\(headers.prettyPrinted)\n\n"
        }

        if let parameters = request.httpBody {
            log += ":::::: 📑 PARAMETERS ::::::\n\(parameters.prettyPrinted)\n\n"
        }

        if let data {
            log += ":::::: 📲 RESPONSE ::::::\n \(data.prettyPrinted)\n"
        }

        let logComponents = [log, "\n======"]
        Self.handleLog(level: .request, logComponents: logComponents, shouldLogContext: shouldLogContext, context: context)
    }

    static func error(_ error: Error,
                      notes: String,
                      shouldLogContext: Bool = true,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line) {
        let context = ContextLog(file: file, function: function, line: line)
        Self.handleLog(level: .error, error: error, notes: notes, shouldLogContext: shouldLogContext, context: context)
    }

    fileprivate static func genericLog(_ message: String,
                                       level: LogLevel,
                                       shouldLogContext: Bool,
                                       context: ContextLog,
                                       category: String? = nil) {
        let logComponents = ["message: ", message, "\n======"]
        Self.handleLog(level: level, logComponents: logComponents, shouldLogContext: shouldLogContext, context: context, category: category)
    }

    fileprivate static func handleLog(level: LogLevel,
                                      error: Error,
                                      notes: String,
                                      shouldLogContext: Bool,
                                      context: ContextLog) {
        let logComponents = ["[Error] ", error.localizedDescription, "\n", "Notes: ", notes, "\n======"]
        Self.handleLog(level: level, logComponents: logComponents, shouldLogContext: shouldLogContext, context: context)
    }

    fileprivate static func handleLog(level: LogLevel,
                                      logComponents: [String],
                                      shouldLogContext: Bool,
                                      context: ContextLog,
                                      category: String? = nil) {
        var fullString = ""

        if shouldLogContext {
            fullString += "====== \(level.prefix) \(context.description) ======\n"
        } else {
            fullString += "====== \(level.prefix) \(level.rawValue.uppercased()) ======\n"
        }

        fullString += logComponents.joined(separator: " ")

        #if DEBUG || ENTERPRISE
        let subsystem = Bundle.main.bundleIdentifier ?? "melia.com"
        let logger = Logger(subsystem: subsystem, category: category ?? context.description)

        switch level {
        case .info, .local, .lifecycle, .dictionary:
            logger.debug("\(fullString, privacy: .public)")
        case .warning:
            logger.warning("\(fullString, privacy: .public)")
        case .success, .request:
            logger.notice("\(fullString, privacy: .public)")
        case .error:
            logger.error("\(fullString, privacy: .public)")
        }
        #endif
    }
}
