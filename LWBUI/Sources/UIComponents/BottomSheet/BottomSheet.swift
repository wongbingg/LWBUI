//
//  BottomSheet.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/06/05.
//

import SwiftUI
import Combine

struct BottomSheet: View {
    @Binding var isShow: Bool
    @State private var isKeyboardVisible = false
    @State private var keyboardHeight: CGFloat = 0.0
    private let springHeight: CGFloat = 20
    let height: CGFloat
    let title: String
    let injectecView: AnyView
//    var sheetBody: some View
    
    var body: some View {
        
        VStack(spacing: 0) {
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
            Rectangle()
                .frame(height: springHeight + keyboardHeight)
                .foregroundColor(Color(.systemGray6))
        }
        .offset(y: isShow ? springHeight : height + springHeight)
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
    
    var dismissButton: some View {
        Button {
            withAnimation {
                isShow = false
            }
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        } label: {
            Image(systemName: "xmark.circle.fill")
                .symbolRenderingMode(.hierarchical)
                .tint(Color(.gray))
        }
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
