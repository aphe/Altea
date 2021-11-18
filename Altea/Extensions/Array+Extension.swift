//
//  Array+Extension.swift
//  Altea
//
//  Created by Afriyandi Setiawan on 20/11/21.
//

import Foundation

extension Array where Element: Hashable {
    func unique() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
