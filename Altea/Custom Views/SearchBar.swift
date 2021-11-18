//
//  SearchBar.swift
//  Altea
//
//  Created by Afriyandi Setiawan on 20/11/21.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    @State private var isEditing = false
    
    var body: some View {
        TextField("Search ...", text: $text)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
            .modifier(ClearButton(text: $text, visible: $isEditing))
            .onTapGesture {
                self.isEditing = true
            }
    }
}

struct ClearButton: ViewModifier {
    @Binding var text: String
    @Binding var visible: Bool
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .isHidden(!visible)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
