//
//  CustomTabBar.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/07/20.
//

import SwiftUI

struct CustomTabBar: View {
    
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
            .debug()
            
            VStack {
                Spacer()
                Rectangle()
                    .frame(width: Constants.deviceWidth, height: 98)
                    .foregroundColor(Color(.systemGray6))
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
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
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
