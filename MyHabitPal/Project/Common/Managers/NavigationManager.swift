//
//  NavigationManager.swift
//  MyHabitPal
//
//

import SwiftUI


class Router: ObservableObject {
	enum Destination: Hashable {
        // access
		case splash
		case home
		
	}

	@Published var rootView: Router.Destination = .splash
	@Published var navPath = [Router.Destination]()

	func navigateToRoot() {
		navPath.removeLast(navPath.count)
	}

	func pushView(router: Router.Destination) {
		navPath.append(router)
	}

	func setAsRoot(router: Router.Destination) {
		navPath.removeLast(navPath.count)
		rootView = router
	}

	func navigateBack() {
		navPath.removeLast()
	}
}
