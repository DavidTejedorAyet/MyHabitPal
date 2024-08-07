//
//  AppConfigUseCase.swift
//  MyHabitPal
//
//  Created by David Tejedor on 7/8/24.
//  Copyright © 2024 mo2o. All rights reserved.
//

import Foundation

protocol AppConfigUseCaseProtocol: ViewModelUseCaseProtocol {
	func setFirstLaunch(_ state: Bool)
	func appHasBeenLaunchedBefore() -> Bool
}

class AppConfigUseCase: UseCaseManager {
}

extension AppConfigUseCase: AppConfigUseCaseProtocol {
	func setFirstLaunch(_ state: Bool) {
		let sharedPreferences = SharedPreferences()
		sharedPreferences.setFirstLaunch(state)
	}

	func appHasBeenLaunchedBefore() -> Bool {
		let sharedPreferences = SharedPreferences()
		return sharedPreferences.appHasBeenLaunchedBefore()
	}
}
