//
//  CustomTabBar.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/07/20.
//

import SwiftUI

struct CustomTabBar: View {
    
    let tabs: [CustomTab]
    let tabBarHeight: CGFloat
    let tabBarBackgroundColor: Color
    let tabBarTintColor: Color
    let tabBarSelectedTintColor: Color
    
    @State private var selection = ""
    
    init(
        tabs: [CustomTab],
        tabBarHeight: CGFloat,
        tabBarBackgroundColor: Color,
        tabBarTintColor: Color,
        tabBarSelectedTintColor: Color
    ) {
        UITabBar.appearance().backgroundColor = .clear
        UITabBar.appearance().unselectedItemTintColor = .clear
        
        self.tabs = tabs
        self.selection = tabs.first?.tag ?? ""
        self.tabBarHeight = tabBarHeight
        self.tabBarBackgroundColor = tabBarBackgroundColor
        self.tabBarTintColor = tabBarTintColor
        self.tabBarSelectedTintColor = tabBarSelectedTintColor
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                
                ForEach(tabs, id: \.tag) { tab in
                    tab.view
                        .tag(tab.tag)
                }
            }
            
            customTabBar(height: tabBarHeight,
                         backgroundColor: tabBarBackgroundColor,
                         tintColor: tabBarTintColor,
                         selectedTintColor: tabBarSelectedTintColor)
        }
    }
}

private extension CustomTabBar {
    
    @ViewBuilder
    func customTabBar(
        height: CGFloat,
        backgroundColor: Color,
        tintColor: Color,
        selectedTintColor: Color
    ) -> some View {
        VStack {
            Spacer()
            Rectangle()
                .frame(width: Constants.deviceWidth, height: height)
                .foregroundColor(backgroundColor)
                .overlay {
                    HStack(spacing: (Constants.deviceWidth-72-96)/3) {
                        ForEach(tabs, id: \.tag) { tab in
                            Button {
                                selection = tab.tag
                            } label: {
                                tab.image
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(selection == tab.tag ? selectedTintColor : tintColor)
                            }
                        }
                    }
                    .padding(.horizontal, 36)
                }
        }
    }
}

// MARK: - Previews

struct CustomTabBar_Previews: PreviewProvider {
    
    static let tabs: [CustomTab] = [
        .init(tag: "home", image: Image(systemName: "house"), view: .init(GreenTabView())),
        .init(tag: "search", image: Image(systemName: "book"), view: .init(BlueTabView())),
        .init(tag: "mypage", image: Image(systemName: "person"), view: .init(RedTabView())),
        .init(tag: "setting", image: Image(systemName: "gear"), view: .init(BlueTabView()))
    ]
    
    static var previews: some View {
        CustomTabBar(
            tabs: tabs,
            tabBarHeight: 64,
            tabBarBackgroundColor: .white,
            tabBarTintColor: Color(hex: 0xDADCE3),
            tabBarSelectedTintColor: .black
        )
        .shadow(color: Color(hex: 0x000000, opacity: 0.02), radius: 6, x: 0, y: -10)
    }
}


// MARK: - Example Views

struct GreenTabView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 300, height: 300)
                .foregroundColor(.green)
            
            Text("\(3)")
                .font(.system(size: 70))
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
    }
}

struct RedTabView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 300, height: 300)
                .foregroundColor(.red)
            
            Text("\(3)")
                .font(.system(size: 70))
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
    }
}
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
