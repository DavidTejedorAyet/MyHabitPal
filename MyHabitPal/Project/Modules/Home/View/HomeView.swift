//
//  
//  HomeView.swift
//  MyHabitPal
//
//  Created by David Tejedor on 7/8/24.
//
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navigationManager: Router
    @StateObject var viewModel = HomeViewModel()

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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
