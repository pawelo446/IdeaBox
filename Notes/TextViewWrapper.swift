//
//  TextViewWrapper.swift
//  IdeaBox
//
//  Created by Paweł on 15/01/2023.
//

import SwiftUI

struct TextViewWrapper: NSViewRepresentable {

    typealias NSViewType = NSView
    let note: Note
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self ,note: note)
    }
    
    func makeNSView(context: Context) -> NSView {
        let nsview = NSTextView()
        nsview.isRichText = true
        nsview.isEditable = true
        nsview.isSelectable = true
        nsview.allowsUndo = true
        nsview.usesInspectorBar = true
        nsview.usesFindPanel = true
        nsview.usesRuler = true
        nsview.usesFindBar = true
        nsview.isGrammarCheckingEnabled = true
        nsview.isContinuousSpellCheckingEnabled = true
        nsview.textStorage?.setAttributedString(note.formattedText)
        nsview.delegate = context.coordinator
        
        return nsview
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        if let nsTextView = nsView as? NSTextView {
            print("it worked")
            nsTextView.textStorage?.setAttributedString(note.formattedText)
            context.coordinator.note = note
        }
    }
    
    class Coordinator: NSObject, NSTextViewDelegate {
        
        var parent: TextViewWrapper
        var note: Note
        init(_ parent: TextViewWrapper, note: Note) {
            self.parent = parent
            self.note = note
        }
        
        func textDidChange(_ notification: Notification) {
            if let textview = notification.object as? NSTextView {
                note.formattedText = textview.attributedString()
            }
        }
    }
}

struct TextViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        TextViewWrapper(note: Note(context: PersistenceController.preview.container.viewContext))
    }
}
