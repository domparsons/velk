//
//  AddNewNoteFromClipboardView.swift
//  Velk
//
//  Created by Dom Parsons on 12/09/2023.
//

import SwiftUI

struct AddNewNoteFromClipboardView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
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
            
            HStack(spacing: 20) {
                Spacer()
                Button("Cancel", role: .cancel) {
                    viewModel.showingNewNoteFromClipboardSheet = false
                }
                .keyboardShortcut(.cancelAction)
                .cornerRadius(6)
                .buttonStyle(.bordered)
                
                Button("OK") {
                    viewModel.addNote(folder: folders[viewModel.folderDestinationIndex], fromClipboard: true)
                }
                .keyboardShortcut(.defaultAction)
                .foregroundColor(.white)
                .cornerRadius(6)
            }
            Button("Enter code manually", action: viewModel.toggleAddNoteView)
                .buttonStyle(.plain)
                .foregroundColor(.blue)
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

//struct AddNewNoteFromClipboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewNoteFromClipboardView()
//    }
//}
