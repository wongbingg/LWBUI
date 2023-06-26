//
//  Animation+.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/05/26.
//

import SwiftUI

extension Animation {
    static func ripple(dampingFraction: CGFloat = 0.65, speed: CGFloat = 1.5) -> Animation {
        Animation
            .spring(dampingFraction: dampingFraction)
            .speed(speed)
    }
}
