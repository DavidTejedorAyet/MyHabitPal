//
//  BackButton.swift
//  MyHabitPal
//
//  Created by David Tejedor on 24/7/24.
//  Copyright © 2024 mo2o. All rights reserved.
//

import SwiftUI

struct BackButton: View {
	enum Style {
		case chevronWhite, chevronGrey, arrowWhite, arrowGrey
	}

	@EnvironmentObject var navigationManager: Router
	var style: Style = .chevronWhite

	private var image: String {
		switch style {
		case .chevronWhite, .chevronGrey: return "chevron_left"
		case .arrowWhite, .arrowGrey: return "arrow_back"
		}
	}
	private var color: ButtonColor {
		switch style {
		case .chevronWhite, .arrowWhite: return .white
		case .chevronGrey, .arrowGrey: return .grey
		}
	}

    var body: some View {
		Button {
			navigationManager.navigateBack()
		} label: {
			Image(image)
		}
		.buttonStyle(.circular(size: 40), color: color)
		.accessibilityIdentifier("back")
    }
}

#Preview {
    BackButton()
		.environmentObject(Router())
}
