//
//  AppError.swift
//
//  Created by David Tejedor on 10/4/24.
//

import Foundation

struct AppError: Identifiable {
    let id = UUID().uuidString
    var title: String = ""
    var description: String = ""

    // Buttons Actions
    let primaryAction: CancelAlertAction
    let secondaryAction: OkAlertAction?

    init(title: String? = nil,
         description: String,
         primaryAction: CancelAlertAction,
         secondaryAction: OkAlertAction? = nil) {
        self.title = title ?? "common.error.default".localized
        self.description = description
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }
}
