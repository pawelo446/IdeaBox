//
//  NoteView.swift
//  IdeaBox
//
//  Created by Paweł on 04/01/2023.
//

import SwiftUI

struct NoteView: View {
    
    @ObservedObject var note: Note
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("notes title", text: $note.title)
                    .textFieldStyle(.plain)
                .font(.title)
                
                Picker(selection: $note.status, label: Text("Status:")) {
                    ForEach(Status.allCases, id: \.self) { status in
                        Text(status.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 220, height: 30)
            }.padding(3)
            //TextEditor(text: $note.bodyText)
            TextViewWrapper(note: note)
            Text("Keywords:")
            Text("linked Notes:")
        }
        .padding(8)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: Note(context: PersistenceController.preview.container.viewContext))
            .frame(width: 400, height: 400)
            .previewLayout(.fixed(width: 400, height: 400))
    }
}
