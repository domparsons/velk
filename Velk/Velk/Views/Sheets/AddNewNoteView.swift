//
//  AddNewNoteView.swift
//  Velk
//
//  Created by Dom Parsons on 27/08/2023.
//

import SwiftUI

struct AddNewNoteView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var folders: FetchedResults<Folder>
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add New Snippet")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("Name", text: $viewModel.newItemTitle)
                .textFieldStyle(.roundedBorder)
            
            TextField("Description", text: $viewModel.newItemDescription)
                .textFieldStyle(.roundedBorder)
            
            Picker("Select a Folder", selection: $viewModel.folderDestinationIndex) {
                ForEach(0..<folders.count, id: \.self) { index in
                    Text(folders[index].folderName ?? "Unknown Folder")
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            ScrollViewReader { proxy in
                TextEditor(text: $viewModel.newItemCode)
                    .scrollContentBackground(.hidden)
                    .background(colorScheme == .dark ? Color.textEditorBackgroundDark : Color.textEditorBackgroundLight)
                    .padding(10)
                    .font(.system(size: 16))
                    .frame(minWidth: 500, minHeight: 200)
            }
            .background(colorScheme == .dark ? Color.textEditorBackgroundDark : Color.textEditorBackgroundLight)
            .cornerRadius(10)
            
            HStack(spacing: 20) {
                Spacer()
                Button("Cancel", role: .cancel) {
                    viewModel.showingNewNoteSheet = false
                }
                .keyboardShortcut(.cancelAction)
                .cornerRadius(6)
                .buttonStyle(.bordered)
                
                Button("OK") {
                    viewModel.addNote(folder: folders[viewModel.folderDestinationIndex], fromClipboard: false)
                }
                .keyboardShortcut(.defaultAction)
                .foregroundColor(.white)
                .cornerRadius(6)
            }
//            Button("", action: viewModel.toggleAddNoteView)
        }
        .onAppear {
            if let selectedFolder = viewModel.selectedFolder {
                if let selectedIndex = folders.firstIndex(where: { $0.id == selectedFolder.id }) {
                    viewModel.folderDestinationIndex = selectedIndex
                }
            }
        }

        .padding()
        .frame(minWidth: 500)
    }
}

//struct AddNewNoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewNoteView()
//    }
//}
