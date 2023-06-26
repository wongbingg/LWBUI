//
//  BottomSheet.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/06/05.
//

import SwiftUI
import Combine

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

protocol KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> { get }
}

extension KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }
}

struct BottomSheet: View, KeyboardReadable {
    @Binding var isShow: Bool
    @State private var isKeyboardVisible = false
    let height: CGFloat
    let title: String
    let injectecView: AnyView
//    var sheetBody: some View
    
    var body: some View {
        
        VStack {
            Spacer()
            Rectangle()
                .frame(width: Constants.deviceWidth, height: height)
                .foregroundColor(Color(.systemGray6))
                .overlay {
                    VStack {
                        HStack {
                            ZStack {
                                Text(title)
                                    .padding()
                                HStack {
                                    Spacer()
                                    dismissButton
                                        .padding(.trailing, 16)
                                }
                            }
                        }
                        Divider()
                        Spacer()
                            .frame(width: Constants.deviceWidth)
                            .overlay {
                                // TODO: 외부에서 주입받은 View
                                injectecView
                            }
                    }
                }
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                    isKeyboardVisible = newIsKeyboardVisible
                    print("is keyboard visible \(newIsKeyboardVisible)")
                }
        }
        .offset(y: isShow ? 0 : height)
        .offset(y: isKeyboardVisible ? -300 : 0)
    }
    
    var dismissButton: some View {
        Button {
            withAnimation {
                isShow = false
            }
        } label: {
            Image(systemName: "xmark.circle.fill")
                .symbolRenderingMode(.hierarchical)
                .tint(Color(.gray))
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

extension View {
    
    func bottomSheet(isShow: Binding<Bool>, height: CGFloat, title: String, injectedView: AnyView) -> some View {
        modifier(BottomSheetInfo(isShowModal: isShow, height: height, title: title, injectedView: injectedView))
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(isShow: .constant(true), height: 300, title: "동의 서약서", injectecView: AnyView(
            VStack {
                Spacer()
                Text("df")
                Text("x테스트 ")
                    .padding(.bottom, 20)
            }
            )
        )
    }
}
