//
//  ModernCategoryView.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/05/26.
//

import SwiftUI

struct ModernCategoryView: View {
    let data: [String]
    @Binding var selectedCategory: String
    
    var body: some View {
        VStack {
            HorizontalScrollBar(
                data: data,
                selectedCategory: $selectedCategory
            )
            .frame(width: UIScreen.main.bounds.width)
            
            
            TabView(selection: $selectedCategory) {
                ForEach(data, id: \.self) { number in
                    ListView(data: number)
                        .tag(number)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

struct ModernCategoriesView_Previews: PreviewProvider {
    @State static var cate = "C View"
    static var previews: some View {
        ModernCategoryView(
            data: ["A is a category of View", "B is also a catego", "C View", "D end View1"],
            selectedCategory: $cate
        )
    }
}
