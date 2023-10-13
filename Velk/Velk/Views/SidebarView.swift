//
//  SidebarView.swift
//  Velk
//
//  Created by Dom Parsons on 02/09/2023.
//

import SwiftUI

struct SidebarView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var folders: FetchedResults<Folder>
    var notes: [Note]
    
    @State private var showingDeleteFolderAlert = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Folders")
                    .font(.subheadline.bold())
                    .padding(.horizontal)
                    .foregroundColor(.secondary)
                Spacer()
            }
            List(folders, id:\.self, selection: $viewModel.selectedFolder) { folder in
                ZStack {
                    Color.clear
                        .contentShape(Rectangle())
                    
                    HStack() {
                        Image(systemName: "folder")
                        Text(folder.wrappedFolderName)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        Spacer()
                    }
                }
                .onTapGesture {
                    viewModel.selectedArea = .sidebarView
                    viewModel.selectedFolder = folder
                    selectNewNote()
                }
                .listRowInsets(EdgeInsets())
                .contextMenu {
                    Button("Delete folder") {
                        showingDeleteFolderAlert = true
                    }
                }
            }
            
            .alert("Deleting a folder will delete all its notes", isPresented: $showingDeleteFolderAlert) {
                Button("OK") {
                    viewModel.deleteFolder()
                }
                Button("Cancel") {}
            } message: {
                Text("Do you wish to continue?")
            }
            Spacer()
            HStack {
                Button(action: {
                    viewModel.showingNewFolderSheet = true
                }) {
                    Image(systemName: "folder.badge.plus")
                }
                .padding()
                .buttonStyle(.plain)
                .font(.title2)
                Spacer()
            }
        }
        .sheet(isPresented: $viewModel.showingNewFolderSheet) {
            AddNewFolderView()
        }
        .onAppear {
            viewModel.selectedFolder = folders[0]
        }

        
    }
    
    func selectNewNote() {
        if viewModel.selectedFolder?.notesArray != [] {
            viewModel.selectedNote = viewModel.selectedFolder?.notesArray[0]
        }
        
//        if notes.count > 0 {
//            if viewModel.selectedNote == sele
//                otes[0] {
//                viewModel.selectedNote = notes[1]
//            } else {
//                viewModel.selectedNote = notes[0]
//            }
//        }
        
//        viewModel.tempCodeString = notes[0].codeBlock ?? "Unknown"
    }
}

//struct SidebarView_Previews: PreviewProvider {
//    static var previews: some View {
//        SidebarView()
//    }
//}
