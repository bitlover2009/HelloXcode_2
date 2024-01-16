//
//  Tag.swift
//  HelloXcode
//
//  Created by David Grau Beltrán  on 14/01/24.
//

import Foundation
import SwiftData

@Model
class Tag {
    @Attribute(.unique) var id: String
    var name: String
    
    @Relationship var notes: [Note]
    @Attribute(.ephemeral) var isChecked = false
    //@Transient var isChecked = false
    //@Attribute(.transient) var isChecked = false
    
    init(id: String, name: String, notes: [Note]) {
        self.id = id
        self.name = name
        self.notes = notes
    }
}
