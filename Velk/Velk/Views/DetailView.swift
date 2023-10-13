//
//  DetailView.swift
//  Velk
//
//  Created by Dom Parsons on 27/08/2023.
//


import SwiftUI
import CodeMirror_SwiftUI

struct DetailView: View {

    @State private var codeBlock = "print(\"Hello, World!\")"
    @State private var codeMode = CodeMode.swift.mode()
    @State private var selectedTheme = 0
    @State private var fontSize = 16
    @State private var showInvisibleCharacters = true
    @State private var lineWrapping = true

    var themes = CodeViewTheme.allCases.sorted {
        return $0.rawValue < $1.rawValue
    }

    var body: some View {
        Text("Code")
        CodeView(
            theme: themes[selectedTheme],
            code: $codeBlock,
            mode: codeMode,
            fontSize: fontSize,
            showInvisibleCharacters: showInvisibleCharacters,
            lineWrapping: lineWrapping
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
    }


    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var viewModel: ViewModel
    
    var folders: FetchedResults<Folder>
    let notes: [Note]
//    
//    var body: some View {
//        GeometryReader { geo in
//            VStack {
//                if notes.count > 0 && viewModel.selectedNote != nil {
//                    HStack {
//                        VStack(alignment: .leading) {
//                            
//                            HStack {
//                                VStack(alignment: .leading, spacing: 10) {
//                                    Text(viewModel.selectedNote!.wrappedName)
//                                        .font(.title)
//
//                                    Text(viewModel.selectedNote!.wrappedCodeDescription)
//                                        .foregroundColor(.secondary)
//                                }
//                                Spacer()
//                                VStack(alignment: .trailing) {
//                                    Button {
//                                        viewModel.copyCode()
//                                    } label: {
//                                        Image(systemName: "doc.on.doc")
//                                            .font(.title2)
//                                    }
//                                    .buttonStyle(.plain)
//                                }
//                            }
//                            
//
//                                
//                         
//                            
//                            
//                        }
//                        .padding()
//                    }
//                    Spacer()
//
//                } else {
//                    Spacer()
//                    HStack {
//                        Spacer()
//                        Text("No note selected")
//                            .font(.title)
//                            .foregroundColor(.secondary)
//                        Spacer()
//                    }
//                    Spacer()
//                }
//            }
//            .onChange(of: geo.size) { newSize in
//                viewModel.calculateMaxLineWidth()
//            }
//        }
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                Button {
//                    viewModel.showingNewNoteFromClipboardSheet = true
//                } label: {
//                    Image(systemName: "doc.badge.plus")
//                }
//            }
//            ToolbarItem(placement: .automatic) {
//                Button {
//                    viewModel.showingDeletionConfirmation = true
//                } label: {
//                    Image(systemName: "trash")
//                }
//                .disabled(viewModel.selectedNote == nil)
//            }
//
//        }
//        .sheet(isPresented: $viewModel.showingNewNoteSheet) {
//            AddNewNoteView(folders: folders)
//        }
//        .sheet(isPresented: $viewModel.showingNewNoteFromClipboardSheet) {
//            AddNewNoteFromClipboardView(folders: folders)
//        }
//        .alert("Delete note", isPresented: $viewModel.showingDeletionConfirmation) {
//            Button("Cancel", role: .cancel) {}
//            Button("Delete", role: .destructive) {
//                viewModel.deleteNote()
//                selectNewNote()
//            }
//        } message: {
//            Text("Are you sure you want to delete this note?")
            
//        }
//    }
//    
//    func selectNewNote() {
//        viewModel.selectedNote = notes[0]
//        viewModel.tempCodeString = notes[0].codeBlock ?? "Unknown"
//    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
