//
//  NoteListView.swift
//  IdeaBox
//
//  Created by Paweł on 04/01/2023.
//

import SwiftUI

struct NoteListView: View {
    
    @Binding var selectedNote: Note?
    
    //TODO: reformat this
    @State private var showDeleteAlert = false
    @State private var noteToDelete: Note? = nil
    
    @FetchRequest(fetchRequest: Note.fetch(.all)) private var notes: FetchedResults<Note>
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        VStack {
            HStack {
                Text("Notes")
                    .font(.title)
                Spacer()
                Button(action: {
                    let note = Note(title: "new note", context: context)
                    selectedNote = note
                }, label: {
                    Image(systemName: "plus")
                })
            }
            
            .padding([.top, .horizontal])
            List {
                ForEach(notes) {
                    note in
                    NoteRow(title: note.title, bodyText: note.bodyText, creationDate: note.creationDate, isSelected: selectedNote == note)
                        .onTapGesture {
                            selectedNote = note
                        }
                        .contextMenu(ContextMenu(menuItems: {
                            Button {
                                showDeleteAlert = true
                                noteToDelete = note
                            } label: {
                                Text("Delete Note")
                            }

                        }))
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 2, trailing: 0))
            }
            //TODO: reformat this
            .alert("Are you sure to delete this note?", isPresented: $showDeleteAlert){
                Button("Delete", role: .destructive) {
                    if selectedNote == noteToDelete { selectedNote = nil }
                    Note.delete(note: noteToDelete!)
                    noteToDelete = nil
                    showDeleteAlert = false
                }
                Button("Cancel", role: .cancel) {
                    noteToDelete = nil
                    showDeleteAlert = false

                }
            }
        }
    }
}



struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let request = Note.fetch(.all)
        let fetchedNotes = try? context.fetch(request)
        
        
        return NoteListView(selectedNote: .constant(fetchedNotes?.first))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


