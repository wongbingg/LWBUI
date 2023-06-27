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
                withAnimation {
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
                    .padding()
                    .cornerRadius(30)
                    .border(Color(.systemGray2))
                    .padding()
                
                Button {
                    inputText = ""
                } label: {
                    Capsule()
                        .frame(width: 100, height: 50)
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
