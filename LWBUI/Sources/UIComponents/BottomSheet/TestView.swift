//
//  TestView.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/06/05.
//

import SwiftUI

struct TestView: View {
    @State private var isShowModal: Bool = false
    var body: some View {
        VStack {
            
            Rectangle()
                .frame(width: Constants.deviceWidth, height: 300)
                .foregroundColor(.clear)
                .debug(alignment: .bottom)

            Text("BottomSheet 테스트용 화면입니다. ")
                .debug(.green, alignment: .bottomTrailing)
            
            Rectangle()
                .frame(width: Constants.deviceWidth, height: 300)
                .foregroundColor(.clear)
                .debug(alignment: .top)
            
            Button {
                withAnimation(.ripple()) {
                    isShowModal.toggle()
                }
            } label: {
                Text("Modal")
            }
            .debug(.red, alignment: .bottomLeading)
            
            Spacer()
            
            BottomSheet(height: 300, title: "이메일 변경", isShow: $isShowModal)
        }
        .ignoresSafeArea()
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

// MARK: - View Debugging Tool (from. havi)

public extension View {
    func debug(_ color: Color = .blue, alignment: Alignment = .topTrailing) -> some View {
        modifier(FrameInfo(color: color, alignment: alignment))
    }
}

private struct FrameInfo: ViewModifier {
    let color: Color
    let alignment: Alignment
    
    func body(content: Content) -> some View {
        content
        #if DEBUG
            .overlay(GeometryReader(content: overlay))
        #endif
    }
    
    func overlay(for geometry: GeometryProxy) -> some View {
        ZStack(alignment: alignment) {
            
            Rectangle()
                .strokeBorder(style: .init(lineWidth: 1, dash: [3]))
                .foregroundColor(color)
            
            Text("(\(Int(geometry.frame(in: .global).origin.x)), \(Int(geometry.frame(in: .global).origin.y))) \(Int(geometry.size.width))x\(Int(geometry.size.height))")
                .font(.caption2)

            .minimumScaleFactor(0.5)
            .foregroundColor(color)
            .offset(y: alignment == .topTrailing ? -20 : 0)
            .offset(y: alignment == .topLeading ? -20 : 0)
            .offset(y: alignment == .bottomTrailing ? 20 : 0)
            .offset(y: alignment == .bottomLeading ? 20 : 0)
        }
    }
}
