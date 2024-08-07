//
//  SessionManager.swift
//  MyHabitPal
//
//  Created by David Tejedor on 18/7/24.
//  Copyright © 2024 mo2o. All rights reserved.
//

import Foundation

struct SharedPreferences {
	private let isFirstLaunchKey = "isFirstLaunchKey"

    func appHasBeenLaunchedBefore() -> Bool {
        UserDefaults.standard.bool(forKey: isFirstLaunchKey)
    }

    func setFirstLaunch(_ state: Bool = true) {
        UserDefaults.standard.set(state, forKey: isFirstLaunchKey)
    }

}
