//
//  
//  SplashView.swift
//  MyHabitPal
//
//  Created by David Tejedor on 7/8/24.
//
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var navigationManager: Router
    @StateObject var viewModel = SplashViewModel()

    var body: some View {
        ZStack {
			RadialGradient(gradient: Gradient(colors: [Color.lightYellow, Color.darkYellow]),
						   center: .center,
						   startRadius: 5,
						   endRadius: 500) 
			VStack(spacing: 100) {
				logo
				title
				Spacer()
			}
			.padding(.top, 120)

		}
        .onAppear {
            viewModel.onAppear()
        }
        .onDisappear {
            viewModel.onDisappear()
        }
		.edgesIgnoringSafeArea(.all)

    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
