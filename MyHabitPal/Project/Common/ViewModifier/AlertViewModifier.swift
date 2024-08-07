//
//  AlertViewModifier.swift
//  MyHabitPal
//
//

import SwiftUI

typealias OkAlertAction = (title: String, isDestructive: Bool, action: () -> Void)
typealias CancelAlertAction = (title: String, action: () -> Void)

// MARK: - Modifier
struct AlertViewModifier: ViewModifier {
    @Binding var appError: AppError?

    func body(content: Content) -> some View {
        ZStack {
            content
        }
        .alert(item: $appError) { appAlert in
            guard let secondaryAction = appAlert.secondaryAction else {
                return Alert(title: Text(appAlert.title),
                             message: Text(appAlert.description),
                             dismissButton: .default(Text(appAlert.primaryAction.title),
                                                     action: appAlert.primaryAction.action))
            }

            return Alert(title: Text(appAlert.title),
                         message: Text(appAlert.description),
                         primaryButton: .default(Text(appAlert.primaryAction.title),
                                                 action: appAlert.primaryAction.action),
                         secondaryButton: secondaryAction.isDestructive ?
                                .destructive(Text(secondaryAction.title), action: secondaryAction.action) :
                                .default(Text(secondaryAction.title), action: secondaryAction.action))
        }
    }
}

// MARK: - Extension View
extension View {
    func showAlert(error: Binding<AppError?>) -> some View {
        modifier(AlertViewModifier(appError: error))
    }
}
