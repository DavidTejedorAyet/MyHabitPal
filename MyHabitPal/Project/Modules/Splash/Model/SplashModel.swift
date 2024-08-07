//
//  
//  SplashModel.swift
//  MyHabitPal
//
//  Created by David Tejedor on 7/8/24.
//
//

import Foundation

class SplashModel: Identifiable, Hashable {
    let id = UUID().uuidString

    static func == (lhs: SplashModel, rhs: SplashModel) -> Bool {
        lhs.id == rhs.id
    }

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}