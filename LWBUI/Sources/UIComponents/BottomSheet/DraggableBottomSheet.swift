//
//  DraggableBottomSheet.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/08/02.
//

import SwiftUI
import Combine

struct DraggableBottomSheet: View {
    
    enum Metric {
        static let bottomMarginHeight: CGFloat = 20
    }
    
    @Binding var isShow: Bool
    
    @State private var isKeyboardVisible = false
    @State private var keyboardHeight: CGFloat = 0.0

    let height: CGFloat
    let title: String
    let injectecView: AnyView
    let dragIndicator: AnyView
    
    var body: some View {
        
        VStack(spacing: 0) {
            Spacer()
            Rectangle()
                .frame(width: Constants.deviceWidth, height: height)
                .foregroundColor(Color(.systemGray6))
                .overlay {
                    VStack {
                        
                        Rectangle()
                            .frame(width: Constants.deviceWidth, height: 40)
                            .foregroundColor(Color(.systemGray6))
                            .overlay {
                                dragIndicator
                            }
                        
                        Text(title)
                        
                        Spacer()
                            .frame(width: Constants.deviceWidth)
                            .overlay {
                                injectecView
                            }
                    }
                }
                .cornerRadius(16, corners: [.topLeft, .topRight])
            Rectangle()
                .frame(height: Metric.bottomMarginHeight + keyboardHeight)
                .foregroundColor(Color(.systemGray6))
        }
        .offset(y: isShow ? Metric.bottomMarginHeight : height + Metric.bottomMarginHeight)
        .animation(.ripple(), value: isShow)
        .animation(.linear(duration: 0.2), value: keyboardHeight)
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    self.keyboardHeight = keyboardSize.height
                }
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                self.keyboardHeight = 0.0
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self)
        }
    }
}

struct DraggableBottomSheet_Previews: PreviewProvider {
    @State static var offsetY: CGFloat = 0.0
    
    static var previews: some View {
        DraggableBottomSheet(isShow: .constant(true), height: 300, title: "동의 서약서", injectecView: AnyView(
            VStack {
                Spacer()
                Text("df")
                Text("x테스트 ")
                    .padding(.bottom, 20)
            }
        ), dragIndicator: AnyView(
            Capsule()
                .frame(width: 34, height: 5)
        )
        )
    }
}
