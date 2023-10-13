//
//  ViewModel.swift
//  Velk
//
//  Created by Dom Parsons on 21/08/2023.
//

import Foundation
import Cocoa

enum SelectedArea {
    case sidebarView
    case notesListView
    case detailView
}


class ViewModel: ObservableObject {
    
    // The managed object context used to interact with Core Data.
    let moc: NSManagedObjectContext
    
    // Initializes the ViewModel with a managed object context.
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    // The current selected note (optional incase there are no notes)
    @Published var selectedNote: Note?
    @Published var selectedFolder: Folder?
    
    @Published var selectedArea: SelectedArea = .sidebarView
    
    // Properties for adding a new Folder
    @Published var newFolderName: String = ""
    @Published var showingNewFolderSheet = false
    
    // Properties for adding a new Note
    @Published var newItemTitle: String = ""
    @Published var newItemDescription: String = ""
    @Published var newItemCode: String = ""
    @Published var showingNewNoteSheet = false
    @Published var showingNewNoteFromClipboardSheet = false
    
    // A temporary string property for editing code
    @Published var tempCodeString: String = "Unknown"
    
    // Holds the selected folder index to add the note to the correct folder
    @Published var folderDestinationIndex = 0
    
    // Max width of the text editor without wrapping text. Calculated with the tempCodeString.
    @Published var textEditorMaxWidth: CGFloat = 100
    
    // Error handling properties
    @Published var showingErrorAlert = false
    @Published var errorMessage = ""
    
    // Deletion confirmation alert
    @Published var showingDeletionConfirmation = false
    
    // Function to update the temporary code string (the displayed code) when a Note is selected.
    func updateTempCodeString() {
        tempCodeString = selectedNote!.wrappedCodeBlock
    }
    
    // Function to copy the code to the clipboard (pasteboard)
    func copyCode() {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(tempCodeString, forType: .string)
    }
    
    // Function to validate the folder name is not empty
    func validateFolderName() -> Bool {
        if newFolderName != "" {
            return true
        } else {
            return false
        }
    }
    
    // Function to calculate the maximum line width
    func calculateMaxLineWidth() {
        let lines = tempCodeString.components(separatedBy: "\n")
        let font = NSFont.systemFont(ofSize: 16, weight: .regular)
        textEditorMaxWidth = lines.map { line in
            (line as NSString).size(withAttributes: [.font: font]).width + 50
        }.max() ?? 0
    }
    
    func toggleAddNoteView() {
        if showingNewNoteFromClipboardSheet {
            showingNewNoteFromClipboardSheet = false
            showingNewNoteSheet = true
        } else {
            showingNewNoteSheet = false
            showingNewNoteFromClipboardSheet = true
        }
    }
    
//    func appLoaded() {
//        viewModel.selectedFolder = folders[0]
//        viewModel.selectedNote = 
//    }
}
