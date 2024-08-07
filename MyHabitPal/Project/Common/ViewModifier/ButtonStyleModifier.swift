//
//  ButtonStyleModifier.swift
//  Pruebas_swiftui
//
//  Created by David Tejedor on 2/7/24.
//

import SwiftUI

enum ButtonStyle: Equatable {
	case circular(size: CGFloat)
	case big  // 46px alto, 24 padding
	case medium // 38px alto, 16 padding
	case small // 32px alto, 16 padding
	case fullWidth // 46px alto, ancho adaptable a la vista
	case underlined
}
enum ButtonColor {
	case white, black, grey, red, whiteWithBorder
}

struct ButtonStyleModifier: ViewModifier {
	var style: ButtonStyle
	var color: ButtonColor
	@Binding var isEnabled: Bool

	var backgroundColor: Color {
		switch color {
		case .black: .customBlack
		case .white, .whiteWithBorder: .white
		case .grey: .grey40
		case .red: .recRed
		}
	}

	var foregroundColor: Color {
		switch color {
		case .black, .red: .white
		case .white, .whiteWithBorder, .grey: .customBlack
		}
	}

	var borderColor: Color {
		switch color {
		case .whiteWithBorder: .customBlack
		default: .clear
		}
	}

	var width: CGFloat? {
		switch style {
		case .circular(let size): size
		default: nil
		}
	}

	var height: CGFloat {
		switch style {
		case .circular(let size): size
		case .big, .fullWidth: 46
		case .medium: 38
		case .small, .underlined: 32
		}
	}
	var radius: CGFloat {
		switch style {
		default: height / 2
		}
	}
	var verticalPadding: CGFloat {
		switch style {
		case .circular: 8
		default: 12
		}
	}
	var horizontalPadding: CGFloat {
		switch style {
		case .big: 24
		case .medium, .small: 16
		case .circular: 8
		default: 8
		}
	}
	var maxWidth: CGFloat? {
		switch style {
		case .fullWidth: .infinity
		default: nil
		}
	}

	func body(content: Content) -> some View {
		content
			.frame(maxWidth: maxWidth)
			.textStyle(font: .graphik(size: 16, weight: .medium), color: foregroundColor)
			.padding(.vertical, verticalPadding)
			.padding(.horizontal, horizontalPadding)
			.frame(width: width, height: height)
//			.background(isEnabled ? backgroundColor : .disabledGrey)
			.background(
				RoundedRectangle(
					cornerRadius: radius,
					style: .continuous
				)
				.stroke(borderColor, lineWidth: 2)
				.background(isEnabled ? backgroundColor : .disabledGrey)

			)
			.clipShape(RoundedRectangle(cornerRadius: radius))

			.foregroundStyle(foregroundColor)
			.overlay {
				if style == ButtonStyle.underlined {
					Rectangle()
						.fill(foregroundColor)
						.frame(height: 1)
						.padding(.top, 18)
						.padding(.horizontal, 8)
					
				}
			}
	}
}

extension View {
	func buttonStyle(
		_ style: ButtonStyle = .big,
		color: ButtonColor = .black,
		isEnabled: Binding<Bool> = .constant(true)
	) -> some View {
		self.modifier(
			ButtonStyleModifier(
				style: style,
				color: color,
				isEnabled: isEnabled
			)
		)
	}
}

// swiftlint:disable closure_body_length
#Preview {
	VStack {
		Button(action: {}, label: {
			Text("Grande")
		})
		.buttonStyle(.big)
		Button(action: {}, label: {
			Text("Mediano")
				.textStyle(font: .graphik(size: 13, weight: .medium), color: .white)
		})
		.buttonStyle(.medium, color: .red)
		Button(action: {}, label: {
			Text("Pequeño")
				.textStyle(font: .graphik(size: 13, weight: .medium), color: .white)
		})
		.buttonStyle(.small)
		Button(action: {}, label: {
			Text("Ancho adaptable")
		})
		.buttonStyle(.fullWidth)
		HStack {
		Button(action: {}, label: {
				Text("Ancho adaptable")
			})
			.buttonStyle(.fullWidth)
		Button(action: {}, label: {
				Text("Ancho adaptable")
			})
			.buttonStyle(.fullWidth, color: .grey)
		}
		HStack {
			Button(action: {}, label: {
				Image("rec")
			})
			.buttonStyle(.circular(size: 48), color: .red)
			.shadow(color: .recRed, radius: 3)
			Button(action: {}, label: {
				Image("photo_camera")
			})
			.buttonStyle(.circular(size: 40))
			Button(action: {}, label: {
				Image("arrow_back")
			})
			.buttonStyle(.circular(size: 40), color: .white)
		}
		Button(action: {}, label: {
			HStack {
				Text("Botón con imagen")
					.textStyle(font: .graphik(size: 13, weight: .medium), color: .white)
				Image("photo_camera")
			}
		})
		.buttonStyle(.medium)
		Button(action: {}, label: {
			Text("Botón deshabilitado")
				.textStyle(font: .graphik(size: 13, weight: .medium))
		})
		.buttonStyle(.medium, isEnabled: .constant(false))
		Button(action: {}, label: {
			Text("Botón subrayado")
				.textStyle(font: .graphik(size: 13, weight: .medium))
		})
		.buttonStyle(.underlined, color: .white)
		Button(action: {}, label: {
			Text("Botón con bordes")
				.textStyle(font: .graphik(size: 13, weight: .medium))
		})
		.buttonStyle(.fullWidth, color: .whiteWithBorder)
	}
}
