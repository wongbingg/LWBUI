//
//  TestView.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/06/05.
//

import SwiftUI

struct TestView: View {
    @State private var isShowModal: Bool = false
    @State private var inputText: String = ""
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: Constants.deviceWidth, height: 300)
                .foregroundColor(.clear)

            Text("BottomSheet 테스트용 화면입니다. ")
            
            Rectangle()
                .frame(width: Constants.deviceWidth, height: 300)
                .foregroundColor(.clear)
            
            Button {
                withAnimation(.ripple()) {
                    isShowModal.toggle()
                }
            } label: {
                Text("Modal")
            }
            
            Spacer()
        }
        .bottomSheet(isShow: $isShowModal, height: 250, title: "이메일 변경", injectedView: AnyView(
            VStack {
                TextField("이메일을 변경해주세요", text: $inputText)
                    .cornerRadius(14)
                    .padding()
                    .border(Color(.systemGray2))
                    .padding()
                
                Button {
                    inputText = ""
                } label: {
                    Capsule()
                        .frame(width: 200, height: 50)
                        .overlay {
                            Text("확인")
                                .foregroundColor(.white)
                        }
                }
            }
        ))
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
