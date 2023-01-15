//
//  SwiftUIView.swift
//  IdeaBox
//
//  Created by Paweł on 05/01/2023.
//

import SwiftUI

struct NoteRow: View {
    
    let title: String
    let bodyText: String
    let creationDate: Date
    let isSelected: Bool
    
    let selectedColor: Color = Color("selectedColor")
    let unselectedColor: Color = Color("unselectedColor")
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 3) {
            HStack {
                Text(title).bold()
                Spacer()
                Text(creationDate, formatter: itemFormatter)
                    .font(.footnote)
            }
            Text(bodyText)
                .lineLimit(3)
                .font(.caption)
                
        }
        .padding(5)
        .background( RoundedRectangle(cornerRadius: 5).fill( isSelected ? selectedColor : unselectedColor ) )

    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        VStack (spacing: 5) {
            NoteRow(title: "Note test", bodyText: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", creationDate: Date(), isSelected: true)
            NoteRow(title: "Note test", bodyText: "short note.", creationDate: Date(), isSelected: false)
            NoteRow(title: "Note test", bodyText: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", creationDate: Date(), isSelected: false)
        }
        .padding()
        .frame(width: 250)
    }
}
