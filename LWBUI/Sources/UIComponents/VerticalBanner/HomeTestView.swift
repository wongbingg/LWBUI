//
//  HomeTestView.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/07/05.
//

import SwiftUI

struct HomeTestView: View {
    @State private var category: String = "포트폴리오"
    
    var body: some View {
        VStack {
            VerticalBanner(bannerWidth: 428, bannerHeight: 200)
                .debug()

            ModernCategoryView(
                data: ["전체", "포트폴리오", "핀테크 트렌드", "핫 플레이스", "쿨 피플", "잘알못 칼럼"],
                selectedCategory: $category
            )
        }
    }
}

struct HomeTestView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTestView()
    }
}
