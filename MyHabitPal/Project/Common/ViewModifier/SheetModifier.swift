//
//  SheetModifier.swift
//  MyHabitPal
//
//  Created by David Tejedor on 1/8/24.
//  Copyright © 2024 mo2o. All rights reserved.
//

import SwiftUI

struct SheetStyleModifier: ViewModifier {
	@State var sheetHeight: CGFloat = .zero

	func body(content: Content) -> some View {
		content
			.padding(24)
			.presentationDragIndicator(.hidden)
			.presentationCornerRadius(32)
			.overlay {
				GeometryReader { geometry in
					Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
				}
			}
			.onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
				sheetHeight = newHeight
			}
			.presentationDetents([.height(sheetHeight)])
	}
}

extension View {
	func sheetStyle() -> some View {
		self.modifier(SheetStyleModifier())
	}
}

struct InnerHeightPreferenceKey: PreferenceKey {
	static let defaultValue: CGFloat = .zero
	static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
		value = nextValue()
	}
}
