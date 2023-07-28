//
//  DynamicHeader.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/07/28.
//

import SwiftUI

struct DynamicHeader: View {
    @State private var xpositionOffset: CGFloat = 0.0
    
    let height: CGFloat
    let images: [Image]
    
    var body: some View {
        ScrollView {
            HStack(spacing: 0) {
                ForEach(images, id: \.self) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(minHeight: height)
                }
            }
            .offset(x: xpositionOffset)
            .frame(height: height)
            .mask {
                Rectangle()
                    .frame(width: Constants.deviceWidth-32, height: height)
                    .cornerRadius(10, corners: .allCorners)
            }
            .overlay {
                Text("안녕하세요 PIECE입니다.")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.heavy)
            }
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 120.0)) {
                xpositionOffset = -Constants.deviceWidth * 3
            }
        }
    }
}

struct DynamicHeader_Previews: PreviewProvider {
    static var previews: some View {
        DynamicHeader(
            height: 500,
            images: [
                Image("backgroundImage2"),
                Image("backgroundImage2"),
                Image("backgroundImage2")
            ]
        )
    }
}

extension Image: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(1)
    }
}

