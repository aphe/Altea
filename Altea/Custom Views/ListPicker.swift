//
//  ListPicker.swift
//  Altea
//
//  Created by Afriyandi Setiawan on 20/11/21.
//

import SwiftUI

struct ListPicker: View {
    @Binding var dismiss: Bool
    @Binding var selected: String
    var list: [String]
    var body: some View {
        List {
            ForEach(list, id: \.self) { item in
                Button {
                    dismiss.toggle()
                    selected = item
                } label: {
                    Text(item)
                        .font(.subheadline)
                }.foregroundColor(.black)
            }
        }
    }
}

struct ListPicker_Previews: PreviewProvider {
    static var previews: some View {
        ListPicker(dismiss: .constant(true), selected: .constant("selected"), list: [])
    }
}
