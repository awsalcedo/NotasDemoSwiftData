//
//  Note.swift
//  NotasDemoSwiftData
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 19/9/24.
//

import Foundation
import SwiftData

@Model
final class Note {
    @Attribute(.unique) var id: UUID
    var title: String
    var content: String
    var cratedAt: Date
    var categoryName: String?
    
    init(id: UUID, title: String, content: String, categoryName: String? = nil) {
        self.id = id
        self.title = title
        self.content = content
        self.cratedAt = Date() //para asignar la fecha justo cuando se está creando
        self.categoryName = categoryName
    }
}
