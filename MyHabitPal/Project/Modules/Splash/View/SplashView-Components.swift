//
//  
//  SplashView-Components.swift
//  MyHabitPal
//
//  Created by David Tejedor on 7/8/24.
//
//

import SwiftUI

extension SplashView {
    var logo: some View {
        Image("logo")
			.imageStyle(width: 180, height: 180)
    }

	var title: some View {
		Text("MyHabitPal")
			.stroke(color: .greyLogo, width: 7)
			.textStyle(font: .quicksand(size: 60, weight: .bold),color: .white)
	}
}
