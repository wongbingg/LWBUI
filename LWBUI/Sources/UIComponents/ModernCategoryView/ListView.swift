//
//  ListView.swift
//  LWBUI
//
//  Created by 이원빈 on 2023/06/02.
//

import SwiftUI

struct ListView: View {
    let data: String
    
    var body: some View {
        List {
            ForEach(fetchData(from: data), id: \.self) {
                Text($0)
                    .frame(height: 80)
                    .foregroundColor(Color(.label))
                    .listRowSeparator(.visible, edges: .all)
//                    .debug(alignment: .topTrailing)
            }
        }
        .listStyle(.inset)
    }
    
    func fetchData(from data: String) -> [String] {
        var dataList: [String] = []
        for i in 1...30 {
            let element = "\(data) -- \(i)"
            dataList.append(element)
        }
        return dataList
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(data: "hello")
    }
}
