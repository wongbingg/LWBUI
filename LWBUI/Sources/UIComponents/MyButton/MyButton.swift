//
//  MyButton.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/07/10.
//
// MARK: Design System을 이용해 UIComponents 만들기.

import SwiftUI

struct MyButton: View {
    
    // MARK: - Design System
    
    enum MyButtonColor {
        case `default`
        case accent
        case error
        
        var mainColor: Color {
            switch self {
            case .`default`: return .white
            case .accent: return .green.opacity(0.85)
            case .error: return .red.opacity(0.6)
            }
        }
        
        var detailColor: Color {
            switch self {
            case .`default`: return .white
            case .accent: return .white
            case .error: return .white
            }
        }
    }
    
    enum MyButtonIcon {
        case leading(_ icon: Image)
        case trailing(_ icon: Image)
    }
    
    enum MyButtonSize {
        case large
        case medium
        case small
        
        var size: CGRect {
            switch self {
            case .large: return CGRect(x: 0, y: 0, width: 300, height: 80)
            case .medium: return CGRect(x: 0, y: 0, width: 150, height: 50)
            case .small: return CGRect(x: 0, y: 0, width: 100, height: 40)
            }
        }
    }
    
    // MARK: - Properties
    
    private let color: MyButtonColor
    private let icon: MyButtonIcon?
    private let size: MyButtonSize
    private let title: String
    private let action: () -> Void
    
    init(
        color: MyButtonColor = .default,
        size: MyButtonSize = .medium,
        icon: MyButtonIcon? = nil,
        title: String,
        action: @escaping () -> Void
    ) {
        self.color = color
        self.icon = icon
        self.title = title
        self.action = action
        self.size = size
    }
    
    var body: some View {
        Button {
            //
        } label: {
            buttonForColor
        }

    }
    
    private var buttonForColor: some View {
        buttonContent
            .foregroundColor(color.detailColor)
            .background(
                Capsule().fill(color.mainColor))
    }
    
    private var buttonContent: some View {
        HStack(spacing: 16) {
            if case .leading(let image) = icon {
                iconView(for: image)
            }
            
            Text(title)
            
            if case .trailing(let image) = icon {
                iconView(for: image)
            }
        }
        .frame(width: size.size.width, height: size.size.height)
    }
    
    private func iconView(for image: Image) -> some View {
        image
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 20, height: 20)
    }
}

// MARK: - Preview

struct MyButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            MyButton(color: .error,
                     size: .medium,
                     icon: .leading(Image(systemName: "person.circle.fill")),
                     title: "Press me!"
            ) {
                print("")
            }
            Spacer()
        }
    }
}
