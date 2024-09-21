//
//  CategoryEditorView.swift
//  NotasDemoSwiftData
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 20/9/24.
//

import SwiftUI

struct CategoryEditorView: View {
    @State private var name: String
    @State private var selectedIcon: String = "folder"
    let onSave: (Category) -> Void
    @Environment(\.dismiss) private var dismiss
    
    let icons = ["folder", "bookmark", "star", "flag", "bell", "clock", "calendar", "house", "car", "person"]
    
    init(name: String, selectedIcon: String, onSave: @escaping (Category) -> Void) {
        self.name = name
        self.selectedIcon = selectedIcon
        self.onSave = onSave
        
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nombre de la categoría", text: $name)
                Picker("Icono", selection: $selectedIcon) {
                    ForEach(icons, id: \.self) { icon in
                        Image(systemName: icon).tag(icon)
                    }
                }
            }
        }
    }
}

#Preview {
    CategoryEditorView(name: "", selectedIcon: "folder", onSave: {_ in } )
}
