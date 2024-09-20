//
//  NoteEditorView.swift
//  NotasDemoSwiftData
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 19/9/24.
//

import SwiftUI

struct NoteEditorView: View {
    @Environment(\.modelContext) private var context
    @State private var title: String
    @State private var content: String
    @State private var selectedCategoryName: String?
    let note: Note?
    let categories: [Category]
    // Para enviar la nueva nota a la pantalla principal para que en esa pantalla se guarde en la BDD
    let onSave: (Note) -> Void
    @Environment(\.dismiss) private var dismiss
    
    init(note: Note?, categories: [Category], onSave: @escaping (Note) -> Void) {
        self.note = note
        self.categories = categories
        self.onSave = onSave
        _title = State(initialValue: note?.title ?? "")
        _content = State(initialValue: note?.content ?? "")
        _selectedCategoryName = State(initialValue: note?.categoryName)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Título", text: $title)
                TextEditor(text: $content)
                Picker("Categoría", selection: $selectedCategoryName) {
                    Text("Sin categoría").tag(nil as String?)
                    ForEach(categories) { category in
                        HStack {
                            Image(systemName: category.iconName)
                            Text(category.name)
                        }.tag(category.name as String?)
                    }
                }
            }
            .navigationTitle(note == nil ? "Nueva Nota" : "Editar Nota")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let newNote = Note(id: UUID(), title: title, content: content, categoryName: selectedCategoryName)
                        //Pasamos la nuev nota al ContentView para poder agregarla a la BDD en esa vista
                        onSave(newNote)
                        // Para cerrar ésta ventana
                        dismiss()
                    } label: {
                        Text("Guardar")
                    }
                    
                }
                //al usar .cancellationAction el button se coloca automáticamente en el .topBarLeading
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancelar")
                    }
                    
                }
            }
        }
    }
}

#Preview {
    NoteEditorView(note: nil, categories: [], onSave: {_ in })
}
