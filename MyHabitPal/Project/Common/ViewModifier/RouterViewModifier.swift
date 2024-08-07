//
//  RouterViewModifier.swift
//  MO2OTemplateSwiftUI
//
//  Created by David Tejedor on 9/7/24.
//
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length

import SwiftUI

struct RouterViewModifier: ViewModifier {
	@Binding var navPath: [Router.Destination]

	func body(content: Content) -> some View {
		NavigationStack(path: $navPath) {
			content
				.navigationDestination(for: Router.Destination.self) { destination in
					destinationView(for: destination)
				}
		}
	}

	@ViewBuilder
	private func destinationView(for destination: Router.Destination) -> some View {
		switch destination {
		case .splash:
SplashView()
		case .home:
HomeView()
		}
	}
}

// MARK: - Extension View
extension View {
	func navigationTo(navPath: Binding<[Router.Destination]>) -> some View {
		modifier(RouterViewModifier(navPath: navPath))
	}
}
