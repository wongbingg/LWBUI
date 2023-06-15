//
//  HorizontalScrollBar.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/05/26.
//

import SwiftUI

struct HorizontalScrollBar: View {
    var data: [String]
    
    @State private var barWidthDictionary: [String: CGFloat] = [:]
    @State private var barOffsetXDictionary: [String: CGFloat] = [:]
    @State private var barWidth: CGFloat = 0.0
    @Binding var selectedCategory: String
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(alignment: .leading) {
                    HStack(spacing: 10) {
                        ForEach(data, id: \.hashValue) { category in
                            Button {
                                selectedCategory = category
                                withAnimation {
                                    proxy.scrollTo(category, anchor: .center)
                                }
                                barWidth = barWidthDictionary[category] ?? 0.0
                            } label: {
                                Text(category)
                                    .foregroundColor(
                                        category == selectedCategory ?
                                        Color(.label) : Color(.systemGray)
                                    )
                            }
                            .id(category)
                            .background(GeometryReader { textGeometry in
                                Color.clear.onAppear {
                                    guard barWidthDictionary[category] == nil ||
                                            barOffsetXDictionary[category] == nil else { return }
                                    
                                    barWidthDictionary[category] = textGeometry.size.width
                                    barOffsetXDictionary[category] = textGeometry.frame(in: .named("clearColor")).minX - CGFloat(16)
                                }
                                .id("clearColor")
                            })
                        }
                    }
                    
                    Capsule()
                        .offset(x: barOffsetXDictionary[selectedCategory] ?? 0.0)
                        .frame(width:barWidthDictionary[selectedCategory] ?? 0.0, height: 3)
                        .animation(.ripple(), value: selectedCategory)
                }
                .padding()
                .overlay {
                    Divider()
                        .padding(.top, 35)
                }
            }
            .frame(height: 35)
            .background(Color(.secondarySystemBackground))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
                    withAnimation {
                        proxy.scrollTo(selectedCategory, anchor: .center)
                    }
                }
            }
            // 버튼 탭이 아닌 다른 방법으로 selectedCategory가 변경되었을 때 반응
            .onChange(of: selectedCategory) { newValue in
                withAnimation {
                    proxy.scrollTo(newValue, anchor: .center)
                }
            }
        }
    }
}

struct HorizontalScrollBar_Previews: PreviewProvider {
    static var category: String = "핫 플레이스"
    static var selectedCt: Binding<String> = .init {
        category
    } set: { newValue in
        category = newValue
    }

    static var previews: some View {
        HorizontalScrollBar(
            data: ["전체", "포트폴리오", "핀테크 트렌드",
                   "핫 플레이스", "쿨 피플", "잘알못 칼럼",
                   "gkgkdhdh", "Leewonbeen", "ddddddddddddddd"],
            selectedCategory: selectedCt
        )
    }
}
