//
//  CustomTabView.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/07/20.
//

import SwiftUI

struct CustomTabView: View {
    
    enum Tab {
        case home
        case search
        case mypage
        case setting
    }
    
    @State private var selection: Tab = .home
    
    init() {
        UITabBar.appearance().backgroundColor = .clear
        UITabBar.appearance().unselectedItemTintColor = .clear
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                GreenTabView()
                    .tag(Tab.home)
                RedTabView()
                    .tag(Tab.search)
                BlueTabView()
                    .tag(Tab.mypage)
                RedTabView()
                    .tag(Tab.setting)
            }
            
            customTabBar(height: 98,
                         backgroundColor: Color(.systemGray5))
        }
    }
}

struct CustomTab {
    let title: String
    let image: Image
    let view: AnyView
}

private extension CustomTabView {
    
    @ViewBuilder
    func customTabBar(height: CGFloat, backgroundColor: Color) -> some View {
        VStack {
            Spacer()
            Rectangle()
                .frame(width: Constants.deviceWidth, height: height)
                .foregroundColor(backgroundColor)
                .overlay {
                    VStack {
                        HStack(spacing: 69) {
                            Button {
                                selection = .home
                            } label: {
                                Image(systemName: "house")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                            
                            Button {
                                selection = .search
                            } label: {
                                Image(systemName: "person")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                            
                            Button {
                                selection = .mypage
                            } label: {
                                Image(systemName: "book")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                            
                            Button {
                                selection = .setting
                            } label: {
                                Image(systemName: "gear")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        }
                        .tint(.black)
                        
                        Spacer().frame(height: 34)
                    }
                }
        }
        .ignoresSafeArea()
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}

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
