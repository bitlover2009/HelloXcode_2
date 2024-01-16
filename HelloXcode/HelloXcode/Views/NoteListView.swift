//
//  NoteListView.swift
//  HelloXcode
//
//  Created by David Grau Beltrán  on 14/01/24.
//

import SwiftData
import SwiftUI

struct NoteListView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Note.createdAt, order: .reverse) var allNotes: [Note] //error: Cannot infer key path type from context; consider explicitly specifying a root type
        //solution: @Query(sort: \<#Root#>.id que en este caso nuestra Root seria el file Note
    @Query(sort: \Tag.name, order: .forward) var allTags: [Tag]
    @State var noteText = ""
    
    
    var body: some View {
        List {
            //repasar todos estos conceptos
            Section {
                DisclosureGroup("Create a note"){
                    TextField("Enter text",
                              text: $noteText, axis:
                            .vertical)
                    .lineLimit(2...4)
                    
                    DisclosureGroup("Tag With") {
                        if allTags.isEmpty {
                            Text("You don´t have any tags. PLease create one from Tags tab").foregroundStyle(Color.gray)
                        }
                        
                        ForEach(allTags) { tag in
                            HStack {
                                Text(tag.name)
                                if tag.isChecked {
                                    Spacer()
                                    Image(systemName: "checkmark.circle").symbolRenderingMode(.multicolor)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                            .onTapGesture { //is going to toggle this to tab gesture (matched tag with the note)
                                tag.isChecked.toggle() //boolean switch failure falso to true or true to false
                            }
                        }
                    }
                    
                    Button("Save") {
                        createNote()
                    }
                }
            }
            
            Section {
                if allNotes.isEmpty {
                    ContentUnavailableView("You don´t have any notes yet", systemImage: "note")
                } else {
                    ForEach(allNotes) { note in
                        VStack(alignment: .leading){
                            Text(note.content)
                            // we need to update de VStack show or tags
                            if note.tags.count > 0 {
                                Text("Tags:" + note.tags.map { $0.name}.joined(separator: ", ")).font(.caption)
                            }
                            
                            Text(note.createdAt, style: .time)
                                .font(.caption)
                            
                        }
                    }
                    .onDelete { IndexSet in //for delete notes
                        IndexSet.forEach { index in
                            context.delete(allNotes[index])
                        }
                        try? context.save()
                    }
                    
                }
            }
        }
    }
    
    func createNote(){
        
        //we need to associate checkout text with the note in here
        var tags = [Tag]()
        allTags.forEach { tag in //array and then we can pass this to the Note (tags: []) -> tags: tags ..3
            if tag.isChecked { // check if this is true ..1
                tags.append(tag) // It will append this to array (forEach) ..2
                tag.isChecked = false
            }
        }
        
        
        let note = Note(id: UUID().uuidString, content: noteText, createdAt: .now, tags: tags) // se dejo un tag vacio (tags: []) ya que nos arrojo un error: let missing argument for parameter 'tags' in call // tags: tags) !! ..4 (tags -> the text of the array 
        context.insert(note)
        try? context.save()
        noteText = ""
        
    }
}

#Preview {
    NoteListView()
}

