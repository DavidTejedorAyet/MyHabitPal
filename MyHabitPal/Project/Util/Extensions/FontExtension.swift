//
//  FontExtension.swift
//  MyHabitPal
//
//  Created by David Tejedor on 12/4/24.
//

import SwiftUI

extension Font {
	static func dmSans(size: CGFloat) -> Font {
		.custom("DMSans", size: size)
	}

	static func graphik(size: CGFloat, weight: Weight = .regular) -> Font {
		switch weight {
		case .light: .custom("GRAPHIK-LIGHT", size: size) // 300
		case .semibold:  .custom("GRAPHIK-SEMIBOLD", size: size) // 600
		case .medium: .custom("GRAPHIK-MEDIUM", size: size) // 500
		case .bold: .custom("GRAPHIK-BOLD", size: size) // 700
		default: .custom("GRAPHIK-REGULAR", size: size) // 400
		}
	}

	static func quicksand(size: CGFloat, weight: Weight = .regular) -> Font {
		.custom("quicksand", size: size).weight(weight)
	}
}
