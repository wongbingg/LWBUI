//
//  Animation+.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/05/26.
//

import SwiftUI

extension Animation {
    static func ripple() -> Animation {
        Animation
            .spring(dampingFraction: 0.75)
            .speed(1.5)
    }
}
