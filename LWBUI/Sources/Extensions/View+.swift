//
//  View+.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/06/27.
//
// MARK: - View Debugging Tool (from. havi)

import SwiftUI

public extension View {
    
    func debug(_ color: Color = .blue, alignment: Alignment = .topTrailing) -> some View {
        modifier(FrameInfo(color: color, alignment: alignment))
    }
    
    func bottomSheet(isShow: Binding<Bool>, height: CGFloat, title: String, injectedView: AnyView) -> some View {
        modifier(BottomSheetInfo(isShowModal: isShow, height: height, title: title, injectedView: injectedView))
    }
    
    func draggableBottomSheet(isShow: Binding<Bool>, height: CGFloat, title: String, injectedView: AnyView) -> some View {
        modifier(DraggableBottomSheetInfo(isShowModal: isShow, height: height, title: title, injectedView: injectedView))
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
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

struct DraggableBottomSheetInfo: ViewModifier {
    @Binding var isShowModal: Bool
    @State private var offsetY: CGFloat = 0.0
    @State private var accumulatedOffset: CGFloat = 0.0
    
    let height: CGFloat
    let title: String
    let injectedView: AnyView
    
    func body(content: Content) -> some View {
        content
            .overlay {
                
                Color.black.opacity(isShowModal ? 0.3 : 0)
                    .ignoresSafeArea()
                    .disabled(isShowModal == false)
                    .onTapGesture {
                        withAnimation {
                            isShowModal = false
                        }
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to: nil,
                            from: nil,
                            for: nil
                        )
                    }
                
                VStack {
                    Spacer()
                    DraggableBottomSheet(isShow: $isShowModal, height: height, title: title, injectecView: injectedView, dragIndicator: .init(
                        Capsule()
                            .frame(width: 34, height: 5)
                            .padding()
                            .background(Color(.systemGray6))
                            .gesture(drag)
                    ))
                    .offset(y: offsetY)
                }
                .edgesIgnoringSafeArea(.bottom)
                .transition(.move(edge: .bottom))
            }
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { gesture in
                guard gesture.translation.height > -40 else { return }
                
                DispatchQueue.main.async {
                    offsetY = gesture.translation.height * 0.7
                    print(gesture.translation.height)
                }
            }
            .onEnded { gesture in
                guard gesture.translation.height > -40 else {
                    DispatchQueue.main.async {
                        offsetY = 0
                    }
                    return
                }
                
                if gesture.translation.height > height * 0.4 {
                    DispatchQueue.main.async {
                        isShowModal = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        offsetY = 0
                    }
                } else {
                    DispatchQueue.main.async {
                        offsetY = 0
                    }
                }
            }
    }
}

struct BottomSheetInfo: ViewModifier {
    @Binding var isShowModal: Bool
    let height: CGFloat
    let title: String
    let injectedView: AnyView
    
    func body(content: Content) -> some View {
        content
            .overlay {
                
                Color.black.opacity(isShowModal ? 0.3 : 0)
                    .ignoresSafeArea()
                    .disabled(isShowModal == false)
                    .onTapGesture {
                        withAnimation {
                            isShowModal = false
                        }
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to: nil,
                            from: nil,
                            for: nil
                        )
                    }
                
                VStack {
                    Spacer()
                    BottomSheet(isShow: $isShowModal,
                                height: height,
                                title: title,
                                injectecView: injectedView)
                }
                .edgesIgnoringSafeArea(.bottom)
                .transition(.move(edge: .bottom))
            }
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
