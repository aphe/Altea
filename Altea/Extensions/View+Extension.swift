//
//  View+Extension.swift
//  Altea
//
//  Created by Afriyandi Setiawan on 18/11/21.
//

import SwiftUI

extension View {
    @ViewBuilder public func isHidden(_ hidden: Bool, remove: Bool = true) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
