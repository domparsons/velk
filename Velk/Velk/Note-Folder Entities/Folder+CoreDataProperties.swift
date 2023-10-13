//
//  Folder+CoreDataProperties.swift
//  Velk
//
//  Created by Dom Parsons on 02/09/2023.
//
//

import Foundation
import CoreData


extension Folder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder")
    }

    @NSManaged public var folderName: String?
    @NSManaged public var notes: NSSet?
    
    public var wrappedFolderName: String {
        folderName ?? "Unknown folder"
    }
    
    public var notesArray: [Note] {
        let set = notes as? Set<Note> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for notes
extension Folder {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Note)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Note)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

extension Folder : Identifiable {

}
