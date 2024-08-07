//
//  TextStyleModifier.swift
//  MyHabitPal
//
//  Created by David Tejedor on 30/7/24.
//  Copyright © 2024 mo2o. All rights reserved.
//

import SwiftUI

struct TextStyleModifier: ViewModifier {
	var font: Font
	var color: Color

	func body(content: Content) -> some View {
		content
			.font(font)
			.foregroundStyle(color)
			.kerning(-0.8)
	}
}

extension View {
	func textStyle(
		font: Font = .graphik(size: 16),
		color: Color = .customBlack
	) -> some View {
		self.modifier(
			TextStyleModifier(
				font: font,
				color: color
			)
		)
	}
}
