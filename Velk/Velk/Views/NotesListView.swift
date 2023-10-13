//
//  NotesListView.swift
//  Velk
//
//  Created by Dom Parsons on 27/08/2023.
//

import SwiftUI

struct NotesListView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var folders: FetchedResults<Folder>
    let notes: [Note]
    
    @State private var showingDeleteNoteAlert = false

    var body: some View {
        if notes.count > 0 {
            List(notes, id:\.self, selection: $viewModel.selectedNote) { note in
                ZStack {
                    Color.clear
                        .contentShape(Rectangle())
                    
                    VStack {
                        HStack() {
                            Text(note.name ?? "Unknown")
                                .lineLimit(1)
                                .truncationMode(.tail)
                            Spacer()
                        }
                        if note.codeDescription != "" {
                            HStack() {
                                Text(note.codeDescription ?? "Unknown")
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .listRowInsets(EdgeInsets())
                .onTapGesture {
                    viewModel.selectedNote = note
                    viewModel.updateTempCodeString()
                }
                .contextMenu {
                    Menu("Move to") {
                        ForEach(folders) { folder in
                            Button(folder.wrappedFolderName) {
                                viewModel.updateFolder(note: note, folder: folder)
                            }
                        }
                    }
                    Button("Delete note") {
                        showingDeleteNoteAlert = true
                    }
                }
                .onAppear {
                    viewModel.selectedNote = notes[0]
                    viewModel.tempCodeString = notes[0].wrappedCodeBlock
                }
  
  
                
            }
            
            .listStyle(PlainListStyle())
            .alert("Delete note", isPresented: $showingDeleteNoteAlert) {
                Button("OK") {
                    viewModel.deleteNote()
                }
                Button("Cancel") {}
            } message: {
                Text("Do you wish to continue?")
            }
//            .onAppear {
//                viewModel.selectedNote = notes[0]
//            }
            
        } else {
            Text("No notes in this folder")
                .font(.title)
                .foregroundColor(.secondary)
        }
        
    }
}

//struct NotesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotesListView()
//    }
//}
