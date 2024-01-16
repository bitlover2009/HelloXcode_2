//
//  HelloXcodeApp.swift
//  HelloXcode
//
//  Created by David Grau Beltrán  on 29/12/23.
//

import SwiftUI
import SwiftData

@main
struct HelloXcodeApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                noteList
                tagList
            }
            
                .modelContainer(for: [
                    Note.self,
                    Tag.self
                ])
        }
    }
    
    var noteList: some View {
        NavigationStack{
            NoteListView()
                .navigationTitle("Notes")
        }
        .tabItem { Label("Notes", systemImage: "note")}
        
    }
    
    var tagList: some View {
        NavigationStack{
            TagListView()
                .navigationTitle("Tags")
        }
        .tabItem { Label("Tags", systemImage: "tag")}
    }
}
