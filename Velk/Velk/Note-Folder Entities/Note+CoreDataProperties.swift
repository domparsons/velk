//
//  Note+CoreDataProperties.swift
//  Velk
//
//  Created by Dom Parsons on 02/09/2023.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var codeBlock: String?
    @NSManaged public var codeDescription: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var language: String?
    @NSManaged public var name: String?
    @NSManaged public var folder: Folder?
    
    public var wrappedName: String {
        name ?? "Unknown note name"
    }
    
    public var wrappedCodeDescription: String {
        codeDescription ?? "Unknown note description"
    }
    
    public var wrappedCodeBlock: String {
        codeBlock ?? "Unknown code"
    }

}

extension Note : Identifiable {

}
