//
//  collectionExtension.swift
//  MyHabitPal
//
//  Created by David Tejedor on 1/8/24.
//  Copyright © 2024 mo2o. All rights reserved.
//

import Foundation

extension Collection {
	/// Returns the element at the specified index if it is within bounds, otherwise nil.
	subscript (safe index: Index) -> Element? {
		return indices.contains(index) ? self[index] : nil
	}
}
