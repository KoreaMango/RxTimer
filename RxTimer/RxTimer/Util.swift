//
//  Util.swift
//  RxTimer
//
//  Created by 강민규 on 2022/12/13.
//

import Foundation

struct Util{
    // MARK: - data
    static func currentTime() -> String {
        let fommater = DateFormatter()
        fommater.dateFormat = "HH:mm:ss"
        let currentTime = fommater.string(from: Date())
        
        return currentTime
    }
}
