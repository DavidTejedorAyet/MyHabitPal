//
//  
//  HomeViewModel.swift
//  MyHabitPal
//
//  Created by David Tejedor on 7/8/24.
//
//

import Foundation

class HomeViewModel: BaseViewModel {
    // MARK: - Lifecycle
    override init(_ isLoading: Bool = false) {
        super.init(isLoading)
        initData()
    }

    override func onAppear() {
        super.onAppear()
    }

    override func onDisappear() {
        super.onDisappear()
    }
}

// MARK: - Memory Initializer and Release
extension HomeViewModel {
    func initData() {}
    func deinitData() {}
}
