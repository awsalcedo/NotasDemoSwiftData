//
//  ContentView.swift
//  NotasDemoSwiftData
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 19/9/24.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var categories: [Category]
    @Query private var notes: [Note]
    @State private var isAddingNote = false
    @State private var isAddingCategory = false
    @State private var selectedCategoryName: String?
    @State private var selectedNote: Note?
    
    private var filteredNotes: [Note] {
        guard let categoryName = selectedCategoryName else {
            return notes }
        
        return notes.filter {
            $0.categoryName == categoryName
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Categorias")) {
                    ForEach(categories) { category in
                        Button {
                            selectedCategoryName = category.name
                        } label: {
                            HStack {
                                Image(systemName: category.iconName)
                                Text(category.name)
                            }
                        }
                    }
                    Button {
                        selectedCategoryName = nil
                    } label: {
                        HStack {
                            Image(systemName: "tray.full")
                            Text("Todas las Notas")
                        }
                    }

                }
                
                Section(header: Text(selectedCategoryName ?? "Todas las Notas")) {
                    ForEach(filteredNotes) { note in
                        VStack {
                            Text(note.title)
                                .font(.headline)
                            Text(note.content)
                                .font(.subheadline)
                                .lineLimit(3)
                            //Desenvoler el categoryName
                            if let categoryName = note.categoryName,
                               let category = categories.first(where: {
                                   $0.name == categoryName }) {
                                HStack {
                                    Image(systemName: category.iconName)
                                    Text(categoryName)
                                    //Formatter para la fecha
                                }
                                .font(.caption)
                                .foregroundColor(.secondary)
                            }
                        }
                        .onTapGesture {
                            //Para editar la nota
                            selectedNote = note
                        }
                    }
                    .onDelete { index in
                        for i in index {
                            context.delete(filteredNotes[i])
                        }
                    }
                }
            }
            .navigationTitle("Notas")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAddingNote = true
                    } label: {
                        Text("Añadir nota")
                    }
                    
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isAddingCategory = true
                    } label: {
                        Text("Añadir categoria")
                    }

                }
            }
            //Para que aparezca la pantlla de agregar una nota
            .sheet(isPresented: $isAddingNote) {
                NoteEditorView(note: nil, categories: categories) { newNote in
                    addNote(newNote)
                    isAddingNote = false
                }
            }
            //Para que aparezca la pantalla de agregar una categoría
            .sheet(isPresented: $isAddingCategory) {
                CategoryEditorView { newCategory in
                    addNoteCategory(newCategory)
                    isAddingCategory = false
                }
            }
            .sheet(item: $selectedNote) { note in
                //usamos la misma vista para editar
                NoteEditorView(note: note, categories: categories) { updatedNote in
                    updateNote(note, with: updatedNote)
                    selectedNote = nil
                }
            }
        }
    }
    
    private func addNote(_ note: Note) {
        context.insert(note)
    }
    
    private func addNoteCategory(_ category: Category) {
        context.insert(category)
    }
    
    private func updateNote(_ note: Note, with updatedNote: Note) {
        note.title = updatedNote.title
        note.content = updatedNote.content
        note.categoryName = updatedNote.categoryName
    }
}

#Preview {
    ContentView()
}

