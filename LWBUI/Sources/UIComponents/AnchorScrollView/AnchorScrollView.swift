//
//  AnchorScrollView.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/07/19.
//

import SwiftUI

struct AnchorScrollView: View {
    let categories = ["투자개요", "투자정보", "투자공시"]
    let titleHeight = CGFloat(100)
    
    @State private var categoriesYposition: [String: CGFloat] = [:]
    @State private var selectedCategory = "투자개요"
    @State private var scrollOffsetY: CGFloat = 0.0
    @State private var isButtonControl: Bool = false
    
    var body: some View {
        VStack {
            HorizontalScrollBar(
                categories: categories,
                selectedCategory: $selectedCategory,
                isButtonControl: $isButtonControl
            )
            .frame(height: 60)
            
            
            ScrollViewReader { proxy in
                OffsettableScrollView { point in
                    scrollOffsetY = -point.y
                } content: {
                    VStack(alignment: .leading) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                                .font(.title)
                                .padding(.vertical)
                                .id(category)
                                .background(GeometryReader { textGeometry in
                                    Color.clear.onAppear {
                                        guard categoriesYposition[category] == nil else { return }
                                        categoriesYposition[category] = textGeometry.frame(in: .named(category + "uniqueID")).minY
                                    }
                                    .id(category + "uniqueID")
                                })
                            Text(mockString)
                            Spacer().frame(height: 20)
                        }
                    }
                    .padding(.horizontal, 16)
                    .onChange(of: selectedCategory) { newValue in
                        withAnimation {
                            proxy.scrollTo(newValue, anchor: .top)
                        }
                    }
                }
                .onChange(of: scrollOffsetY) { newValue in
                    switch newValue {
                    case ((categoriesYposition[categories[0]]! - titleHeight)...categoriesYposition[categories[0]]!):
                        guard isButtonControl == false else { return }
                        selectedCategory = categories[0]
                    case ((categoriesYposition[categories[1]]! - titleHeight)...categoriesYposition[categories[1]]!):
                        guard isButtonControl == false else { return }
                        selectedCategory = categories[1]
                    case ((categoriesYposition[categories[2]]! - titleHeight)...categoriesYposition[categories[2]]!):
                        guard isButtonControl == false else { return }
                        selectedCategory = categories[2]
                    default:
                        return
                    }
                }
            }
        }
    }
}

struct AnchorScrollView_Previews: PreviewProvider {
    static var previews: some View {
        AnchorScrollView()
    }
}

let mockString = "One of the first mistakes I made was using the wrong property wrapper for my view models. SwiftUI provides a number of property wrappers to help us build data-responsive user interfaces, and three of the most important are @State, @StateObject, and @ObservedObject. Knowing when to use each of these really matters, and getting it wrong will cause all sorts of problems in your code.One of the first mistakes I made was using the wrong property wrapper for my view models. SwiftUI provides a number of property wrappers to help us build data-responsive user interfaces, and three of the most important are @State, @StateObject, and @ObservedObject. Knowing when to use each of these really matters, and getting it wrong will cause all sorts of problems in your code.One of the first mistakes I made was using the wrong property wrapper for my view models. SwiftUI provides a number of property wrappers to help us build data-responsive user interfaces, and three of the most important are @State, @StateObject, and @ObservedObject. Knowing when to use each of these really matters, and getting it wrong will cause all sorts of problems in your code.One of the first mistakes I made was using the wrong property wrapper for my view models. SwiftUI provides a number of property wrappers to help us build data-responsive user interfaces, and three of the most important are @State, @StateObject, and @ObservedObject. Knowing when to use each of these really matters, and getting it wrong will cause all sorts of problems in your code.of the first mistakes I made was using the wrong property wrapper for my view models. SwiftUI provides a number of property wrappers to help us build data-responsive user interfaces, and three of the most important are @State, @StateObject, and @ObservedObject. Knowing when to use each of these really matters, and getting it wrong will cause all sorts of problems in your code.One of the first mistakes I made was using the wrong property wrapper for my view models. SwiftUI provides a number of property wrappers to help us build data-responsive user interfaces, and three of the most important are @State, @StateObject, and @ObservedObject. Knowing when to use each of these really matters, and getting it wrong will cause all sorts of problems in your code."
