//
//  TagListView.swift
//  HelloXcode
//
//  Created by David Grau Beltrán  on 15/01/24.
//

import SwiftData
import SwiftUI

struct TagListView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Tag.name, order: .forward) var allTags: [Tag]
    @State var tagText = ""
    
    var body: some View {
        List {
            Section {
                DisclosureGroup("Create a tag"){
                    TextField("Enter text",
                              text: $tagText, axis:
                            .vertical)
                    .lineLimit(2...4)
                    
                    Button("Save") {
                        createTag()
                    }
                }
            }
            
            Section {
                if allTags.isEmpty {
                    ContentUnavailableView("You don´t have any tags yet", systemImage: "tag")
                } else {
                    ForEach(allTags) { tag in
                        VStack(alignment: .leading){
                            Text(tag.name)
                            
                        }
                    }
                    .onDelete { IndexSet in //for delete notes
                        IndexSet.forEach { index in
                            context.delete(allTags[index])
                        }
                        try? context.save()
                    }
                    
                }
            }
        }
    }
    
    func createTag(){
        let tag = Tag(id: UUID().uuidString, name: tagText, notes: [])
        context.insert(tag)
        try? context.save()
        tagText = ""
        
    }
}

#Preview {
    TagListView()
}
