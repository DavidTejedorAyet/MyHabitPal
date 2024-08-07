//
//  ServerDataManager.swift
//  grandvalira-resorts
//
//  Created by Alberto Fernández-Baíllo on 10/4/24.
//

import Foundation

protocol ViewModelAlertProtocol: AnyObject {
    func manageError(_ error: Error)
}

protocol ViewModelUseCaseProtocol: AnyObject {
    var callbackDelegate: ViewModelAlertProtocol? { get set }
}

class UseCaseManager {
    weak var callbackDelegate: ViewModelAlertProtocol?

    convenience init(delegate: ViewModelAlertProtocol?) {
        self.init()
        self.callbackDelegate = delegate
    }

    // MARK: - Async Await
    func handleAlert(error: Error) async {
        self.callbackDelegate?.manageError(error)
    }

    deinit {}
}
