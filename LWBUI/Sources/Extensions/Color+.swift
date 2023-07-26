//
//  Color+.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/07/26.
//

import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double((hex >> 0) & 0xff) / 255,
            opacity: opacity
        )
    }
}
