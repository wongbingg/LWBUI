//
//  BottomSheet.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/06/05.
//

import SwiftUI

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

struct BottomSheet: View {
    @Binding var isShow: Bool
    let height: CGFloat
    let title: String
    let injectecView: AnyView
//    var sheetBody: some View
    
    var body: some View {
        if isShow {
            VStack {
                Spacer()
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: height)
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
            }
        }
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
                    .disabled(isShowModal == false)
                    .onTapGesture {
                        withAnimation {
                            isShowModal = false
                        }
                    }
                
                VStack {
                    Spacer()
                    BottomSheet(isShow: $isShowModal, height: height, title: title, injectecView: injectedView)
                    .transition(.move(edge: .bottom))
                }
                .edgesIgnoringSafeArea(.bottom)
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
        BottomSheet(isShow: .constant(true), height: 300, title: "동의 서약서", injectecView: AnyView(Text("df")))
    }
}
