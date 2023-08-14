//
//  BlueTabView.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/08/14.
//

import SwiftUI

struct BlueTabView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 300, height: 300)
                .foregroundColor(.blue)
            
            Text("\(3)")
                .font(.system(size: 70))
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
    }
}
