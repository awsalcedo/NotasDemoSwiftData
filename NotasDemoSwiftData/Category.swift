//
//  Ctaegory.swift
//  NotasDemoSwiftData
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 19/9/24.
//

import Foundation
import SwiftData

@Model
final class Category {
    var name: String
    var iconName: String
    
    init(name: String, iconName: String) {
        self.name = name
        self.iconName = iconName
    }
}
