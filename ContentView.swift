//
//  ContentView.swift
//  IdeaBox
//
//  Created by Paweł on 06/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var selectedNote: Note? = nil
    
    var body: some View {
        HSplitView {
            NoteListView(selectedNote: $selectedNote)
                .frame(minWidth: 150, idealWidth: 200,maxWidth: 300)
            
            if selectedNote != nil {
                NoteView(note: selectedNote!)
            } else {
                Text("Select note")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
