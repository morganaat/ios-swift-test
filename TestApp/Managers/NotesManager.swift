//
//  NotesManager.swift
//  TestApp
//
//  Created by Morgana Timbo on 2019-11-19.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation
import UIKit
import CoreData


var entityName = "PersonalNote"

class NotesManager {
    
    public typealias NotesSuccessHandler = ([Note]) -> Void
    public typealias SuccessHandler = () -> Void
    public typealias ErrorHandler = (String) -> Void
    
    static var notes = [Note]()
    
    class func retrieveData(completionSuccess: NotesSuccessHandler? = nil, completionError: ErrorHandler? = nil ) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            NotesManager.notes.removeAll()
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let note = data.value(forKey: "note") as! String
                let date = data.value(forKey: "date") as! String
                let newNote = Note(noteText: note, date: date)
                NotesManager.notes.append(newNote)
            }
            
            if let completion = completionSuccess {
                completion(NotesManager.notes)
            }
            
        } catch {
            
            if let completion = completionError {
                completion("failed")
            }
        }
    }
    
    class func createData(note: Note, completionSuccess: SuccessHandler? = nil, completionError: ErrorHandler? = nil) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        
        let newNote = NSManagedObject(entity: userEntity, insertInto: managedContext)
        newNote.setValue(note.date, forKeyPath: "date")
        newNote.setValue(note.noteText, forKey: "note")
        
        do {
            try managedContext.save()
            NotesManager.retrieveData()
            if let completion = completionSuccess {
                completion()
            }
            
            
        } catch let error as NSError {
            
            if let completion = completionError {
                completion("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    class func updateData(currentNote: Note, newText: String, completionSuccess: SuccessHandler? = nil, completionError: ErrorHandler? = nil) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "note = %@", currentNote.noteText)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            let noteToUpdate = result[0] as! NSManagedObject
            noteToUpdate.setValue(newText, forKey: "note")
            
            do{
                try managedContext.save()
                NotesManager.retrieveData()
                if let completion = completionSuccess {
                    completion()
                }
            }
            catch
            {
                if let completion = completionError {
                    completion(error.localizedDescription)
                }
            }
        } catch {
            
            if let completion = completionError {
                completion(error.localizedDescription)
            }
        }
        
    }
    
    class func deleteData(note: Note, completionSuccess: SuccessHandler? = nil, completionError: ErrorHandler? = nil) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "note = %@", note.noteText)
        
        do {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do {
                try managedContext.save()
                NotesManager.retrieveData()
                if let completion = completionSuccess {
                    completion()
                }
            } catch {
                if let completion = completionError {
                    completion(error.localizedDescription)
                }
            }
            
        } catch {
            if let completion = completionError {
                completion(error.localizedDescription)
            }
        }
    }
}
