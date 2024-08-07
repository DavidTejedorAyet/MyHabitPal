//
//  O2OViewModel.swift
//  MyHabitPal
//
//  Created by David Tejedor on 9/4/24.
//

import Foundation

protocol ObservableViewModelProtocol {
    func onAppear()
    func onDisappear()
}

open class BaseViewModel: ObservableObject, ObservableViewModelProtocol {
    @Published var isLoading = false
    @Published var appError: AppError?

    // MARK: - Lifecycle
    init(_ isLoading: Bool = true) {
        Log.lifecycle("\(String(describing: self)) - 🏗️ init - isLoading: \(isLoading)")
        self.isLoading = isLoading
    }

    func onAppear() {
        Log.lifecycle("\(String(describing: self)) - ☀️ onAppear")
    }

    func onDisappear() {
        Log.lifecycle("\(String(describing: self)) - 🌙 onDisappear")
    }

    // MARK: - UI
    func showLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.isLoading = true
        }
    }

    func dismissLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.isLoading = false
        }
    }

    // MARK: Actions
    func dismissAlertAction() {
        Log.info("dismissAlertAction‼️")
        appError = nil
    }

    func okAlertAction() {
        Log.info("okAlertAction‼️")
        appError = nil
    }

    func getDefault(error: Error) -> AppError {
		AppError(description: "common.error.default".localized,
                        primaryAction: CancelAlertAction(title: "Aceptar", action: dismissAlertAction))
    }

    // MARK: - deinit
    deinit {
        Log.lifecycle("\(String(describing: self)) - ⚰️ deinit")
    }
}

extension BaseViewModel: ViewModelAlertProtocol {
    func manageError(_ error: Error) {
        Task {
            await MainActor.run(body: {
                dismissLoading()
                // haptic(type: .error)
				appError = getDefault(error: error)
            })
        }
    }

    func defaultError(_ error: String) {
        Task {
            await MainActor.run(body: {
                dismissLoading()
                // haptic(type: .error)
                appError = AppError(description: error,
									primaryAction: CancelAlertAction(title: "common.button.accept".localized, action: dismissAlertAction))
            })
        }
    }
}
