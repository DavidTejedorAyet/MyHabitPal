//
//  ImageModifier.swift
//  MyHabitPal
//
//  Created by David Tejedor on 24/7/24.
//  Copyright © 2024 mo2o. All rights reserved.
//

import SwiftUI

struct ImageStyleModifier: ImageModifier {
	var width: CGFloat
	var height: CGFloat
	var color: Color?
	var contentMode: ContentMode

	func body(image: Image) -> some View {
		image
			.resizable()
			.frame(width: width, height: height)
			.aspectRatio(contentMode: contentMode)
			.if({
				return color != nil
			}()) { view in
					view.foregroundStyle(color!)
			}
	}
}

protocol ImageModifier {
	/// `Body` is derived from `View`
	associatedtype Body: View

	/// Modify an image by applying any modifications into `some View`
	func body(image: Image) -> Self.Body
}

extension Image {
	func imageStyle(
		width: CGFloat,
		height: CGFloat,
		color: Color? = nil,
		contentMode: ContentMode = .fit
	) -> some View {
		self.modifier(
			ImageStyleModifier(width: width, height: height, color: color, contentMode: contentMode)
		)
	}
}

extension Image {
	func modifier<M>(_ modifier: M) -> some View where M: ImageModifier {
		modifier.body(image: self)
	}
}
