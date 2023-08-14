//
//  GreenTabView.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/08/14.
//

import SwiftUI

struct GreenTabView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .frame(width: 300, height: 300)
                        .foregroundColor(.green)
                    
                    Text("\(3)")
                        .font(.system(size: 70))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                ForEach((1...15), id: \.self) { _ in
                    Text("heollo")
                        .font(.largeTitle)
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray5))
        }
    }
}
