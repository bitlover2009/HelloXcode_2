//
//  Note.swift
//  HelloXcode
//
//  Created by David Grau Beltrán  on 14/01/24.
//

import Foundation
import SwiftData

@Model
class Note {
    @Attribute(.unique) var id: String
    var content: String
    var createdAt: Date
    
    @Relationship(inverse: \Tag.notes) var tags: [Tag]
    
    init(id: String, content: String, createdAt: Date, tags: [Tag]) {
    // error: @model requires an initializer be provided
    // hay que inicializar todas las variables en este caso faltaba tags
        self.id = id
        self.content = content
        self.createdAt = createdAt
        self.tags = tags
    }
    
    
}
