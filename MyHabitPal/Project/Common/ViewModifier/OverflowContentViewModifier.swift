//
//  OverflowContentViewModifier.swift
//  Melia-B2C
//
//  Created by Javier on 26/2/23.
//

import SwiftUI
/*
 ViewModifier to embed a view in a scrollView only if the content does not fit the height of the screen.
 */

struct OverflowContentViewModifier: ViewModifier {
    let axis: Axis.Set
    @State private var contentOverflow: Bool = false

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .background(
                    GeometryReader { contentGeometry in
                        Color.clear.onAppear {
                            contentOverflow = contentGeometry.size.height > geometry.size.height
                        }
                    }
                )
                .wrappedInScrollView(when: contentOverflow, axis: axis)
        }
    }
}

extension View {
    @ViewBuilder
    func wrappedInScrollView(when condition: Bool, axis: Axis.Set = .vertical) -> some View {
        if condition {
            ScrollView(axis, showsIndicators: false) {
                self
            }
        } else {
            self
        }
    }

    func scrollOnOverflow(_ axis: Axis.Set = .vertical) -> some View {
        modifier(OverflowContentViewModifier(axis: axis))
    }
}
