//
//  DateFormatter++.swift
//  DebugRing
//
//  Created by crzorz on 2023/5/5.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let common: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        return formatter
    }()
}
