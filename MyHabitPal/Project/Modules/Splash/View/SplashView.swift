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
            emptyComponent
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onDisappear {
            viewModel.onDisappear()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
