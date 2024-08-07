//
//  Float.swift
//  MyHabitPal
//
//  Created by David Tejedor on 5/7/24.
//

import Foundation

extension Float {
	func round(to places: Int) -> Float {
		let divisor = pow(10.0, Float(places))
		return (self * divisor).rounded() / divisor
	}
}
