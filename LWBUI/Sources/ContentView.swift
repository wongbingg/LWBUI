//
//  ContentView.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/05/26.
//

import SwiftUI

struct ContentView: View {
    @State private var category: String = "포트폴리오"

    var body: some View {
        // MARK: - Modern Category View
        ModernCategoryView(
            data: ["전체", "포트폴리오", "핀테크 트렌드", "핫 플레이스", "쿨 피플", "잘알못 칼럼"],
            selectedCategory: $category
        )
        
        // MARK: - Bottom Sheet
//        TestView()
        
        // MARK: - Vertical Banner
        
//        VerticalBanner(bannerWidth: 380, bannerHeight: 150)
//        HomeTestView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
