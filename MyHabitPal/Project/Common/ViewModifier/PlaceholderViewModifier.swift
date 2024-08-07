//
//  PlaceholderViewModifier.swift
//  MyHabitPal
//
//  Created by Daniel Plata on 10/7/24.
//  Copyright © 2024 mo2o. All rights reserved.
//

import SwiftUI

struct PlaceHolder<T: View>: ViewModifier {
    var placeHolder: T
    var show: Bool

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if show { placeHolder.padding(.leading, 4).padding(.top, 2) }
            content
        }
    }
}

extension View {
    func placeHolder<T: View>(_ holder: T, show: Bool) -> some View {
        self.modifier(PlaceHolder(placeHolder: holder, show: show))
    }
}
