//
//  VerticalBanner.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/07/03.
//

import SwiftUI

struct VerticalBanner: View {
    
    @State private var isAutoPaging: Bool = true
    @State private var bannerIndex = 0
    @State private var workItem: DispatchWorkItem?
    
    let banners = [(0, "첫번째"), (1, "두번째"), (2, "세번째"), (3, "네번째"), (4, "다섯번째")]
    let bannerWidth: CGFloat
    let bannerHeight: CGFloat
    
    var body: some View {
        
        TabView(selection: $bannerIndex) {
            ForEach(banners, id: \.0) { banner in
                
                Rectangle()
                    .frame(width: bannerWidth, height: bannerHeight)
                    .foregroundColor(Color(.systemGray6))
                    .overlay {
//                        Text("\(banner.1) 광고 입니다.")
                        Image("banner\(banner.0 + 1)")
                            .resizable()
                            .scaledToFill()
                        
                    }
                    .rotationEffect(.degrees(-90))
            }
        }
        .gesture(DragGesture().onChanged({ gesture in
            print("dragged")
            isAutoPaging = false
            sendRequest { isAutoPaging = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: workItem!)
        }))
        .background(Color(.white))
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(width: bannerHeight, height: bannerWidth)
//        .padding(.vertical, -12)
        .cornerRadius(8, corners: .allCorners)
        .rotationEffect(.degrees(90))
        .onChange(of: bannerIndex, perform: { newIndex in
            guard isAutoPaging == true else { return }
            guard newIndex <= banners.count - 1 else {
                bannerIndex = 0
                return
            }
            sendRequest()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: workItem!)
        })
        .onAppear {
            sendRequest()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: workItem!)
        }
    }
}

private extension VerticalBanner {
    func sendRequest(_ closure: (() -> Void)? = nil) {
        cancelRequest()
        
        workItem = DispatchWorkItem {
            withAnimation {
                bannerIndex += 1
            }
            closure?()
        }
    }
    
    func cancelRequest() {
        if let workItem = workItem {
            workItem.cancel()
            self.workItem = nil
        }
    }
}

struct VerticalBanner_Previews: PreviewProvider {
    static var width: CGFloat = 300
    static var previews: some View {
        VerticalBanner(bannerWidth: width, bannerHeight: width * 200/428)
    }
}
