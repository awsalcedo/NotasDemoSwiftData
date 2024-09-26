//
//  CategoryEditorView.swift
//  NotasDemoSwiftData
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 20/9/24.
//

import SwiftUI

struct CategoryEditorView: View {
    @State private var name: String = ""
    @State private var selectedIcon: String = "folder"
    let onSave: (Category) -> Void
    @Environment(\.dismiss) private var dismiss
    
    let icons = ["folder", "bookmark", "star", "flag", "bell", "clock", "calendar", "house", "car", "person"]
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nombre de la categoría", text: $name)
                Picker("Icono", selection: $selectedIcon) {
                    ForEach(icons, id: \.self) { icon in
                        Image(systemName: icon).tag(icon)
                    }
                }
                //coloca la lista en forma horizontal
                .pickerStyle(SegmentedPickerStyle())
            }
            .navigationTitle("Nueva Categoría")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let newCategory = Category(name: name, iconName: selectedIcon)
                        //Para regresar la nueva categoría a la vista anterior
                        onSave(newCategory)
                        dismiss()
                    }label: {
                        Text("Guardar")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
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
    CategoryEditorView(onSave: {_ in } )
}
