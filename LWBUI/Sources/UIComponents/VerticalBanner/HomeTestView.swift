//
//  HomeTestView.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/07/05.
//

import SwiftUI

struct HomeTestView: View {
    
    enum Metric {
        static let bannerWidth: CGFloat = Constants.deviceWidth-32
        static let bannerHeight: CGFloat = 150
    }
    
    @State private var category: String = "포트폴리오"
    
    var body: some View {
        VStack {
            VerticalBanner(
                bannerWidth: Metric.bannerWidth,
                bannerHeight: Metric.bannerHeight
            )

            ModernCategoryView(
                data: ["전체", "포트폴리오", "핀테크 트렌드", "핫 플레이스", "쿨 피플", "잘알못 칼럼"],
                selectedCategory: $category
            )
            .padding(.top, -(Metric.bannerWidth - Metric.bannerHeight))
        }
    }
}

struct HomeTestView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTestView()
    }
}
