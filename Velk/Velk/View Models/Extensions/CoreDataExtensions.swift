//
//  CoreDataExtensions.swift
//  Velk
//
//  Created by Dom Parsons on 17/09/2023.
//

import Foundation
import CoreData
import Cocoa

extension ViewModel {
    
    // Function to add a new Folder to Core Data
    func addFolder() {
        if validateFolderName() {
            let newFolder = Folder(context: moc)
            newFolder.folderName = newFolderName
            do {
                try moc.save()
            } catch {
                showingErrorAlert = true
                errorMessage = "Error creating folder. Please try again."
            }
            showingNewFolderSheet = false
            selectedFolder = newFolder
        } else {
            showingNewFolderSheet = false
            showingErrorAlert = true
            errorMessage = "Invalid folder name"
        }
        
    }
    
    func addNote(folder: Folder, fromClipboard: Bool) {
        let newNote = Note(context: moc)
        newNote.id = UUID()
        newNote.name = newItemTitle
        newNote.codeDescription = newItemDescription
        
        if fromClipboard {
            if let read = NSPasteboard.general.string(forType: .string) {
                newNote.codeBlock = read
            }
        } else {
            newNote.codeBlock = newItemCode
        }
        
        newNote.creationDate = Date.now
        newNote.language = "English??"
        newNote.folder = folder
        selectedNote = newNote
        do {
            try moc.save()
        } catch {
            showingErrorAlert = true
            errorMessage = "Error creating note. Please try again."
        }
        
        newItemTitle = ""
        newItemDescription = ""
        newItemCode = ""
        
        if fromClipboard {
            showingNewNoteFromClipboardSheet = false
        } else {
            showingNewNoteSheet = false
        }
    }
    
    func updateFolder(note: Note, folder: Folder) {
        note.folder = folder
        do {
            try moc.save()
        } catch {
            showingErrorAlert = true
            errorMessage = "Error moving note to new folder. Please try again."
        }
    }

    
    // Function to delete a folder and all of its notes
    func deleteFolder() {
        print("Nice")
        moc.delete(selectedFolder!)
        do {
            try moc.save()
        } catch {
            showingErrorAlert = true
            errorMessage = "Error deleting folder. Please try again."
        }
    }
    
    // Function to delete the currently selected Note
    func deleteNote() {
        moc.delete(selectedNote!)
        do {
            try moc.save()
        } catch {
            showingErrorAlert = true
            errorMessage = "Error deleting note. Please try again."
        }
    }
    
    // Function to update the code of the selected Note
    func updateCode() {
        selectedNote?.codeBlock = tempCodeString
        if moc.hasChanges {
            try? moc.save()
        }
    }
}
