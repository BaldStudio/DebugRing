//
//  DateFormatter+.swift
//  DebugRing
//
//  Created by crzorz on 2023/5/5.
//  Copyright © 2023 BaldStudio. All rights reserved.
//

extension DateFormatter {
    static let common = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
    }
}
