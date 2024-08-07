//
//  
//  HomeModel.swift
//  MyHabitPal
//
//  Created by David Tejedor on 7/8/24.
//
//

import Foundation

class HomeModel: Identifiable, Hashable {
    let id = UUID().uuidString

    static func == (lhs: HomeModel, rhs: HomeModel) -> Bool {
        lhs.id == rhs.id
    }

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}