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
    let height: CGFloat
    let title: String
    
    @Binding var isShow: Bool
    
    var body: some View {
        if isShow {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: height)
                .foregroundColor(Color(.systemGray6))
                .edgesIgnoringSafeArea(.bottom)
                .transition(.move(edge: .bottom))
                .overlay {
                    VStack {
                        HStack {
                            ZStack {
                                Text(title)
                                    .padding()
                                    .debug(alignment: .bottom)
                                HStack {
                                    Spacer()
                                    dismissButton
                                        .debug(alignment: .bottomLeading)
                                        .padding(.trailing, 16)
                                }
                            }
                        }
                        Divider()
                        Spacer()
                    }
                }
                .cornerRadius(16, corners: [.topLeft, .topRight])
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

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(height: 212, title: "이메일 변경", isShow: .constant(true))
    }
}
