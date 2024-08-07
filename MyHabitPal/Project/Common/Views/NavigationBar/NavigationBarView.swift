//
//  NavigationBarView.swift
//  MyHabitPal
//
//  Created by David Tejedor on 30/7/24.
//  Copyright © 2024 mo2o. All rights reserved.
//

import SwiftUI

struct NavigationBarView: View {
	var title: String
	var style: BackButton.Style

    var body: some View {
		ZStack {
			HStack {
				BackButton(style: style)
				Spacer()
			}
			Text(title)
				.textStyle(font: .graphik(size: 18, weight: .medium))
		}
		.frame(height: 64)
    }

	init(_ title: String, style: BackButton.Style) {
		self.title = title
		self.style = style
	}
}

#Preview {
	NavigationBarView("Vista de prueba", style: .arrowGrey)
		.environmentObject(Router())
}
