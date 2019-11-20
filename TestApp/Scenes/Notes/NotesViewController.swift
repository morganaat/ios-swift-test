//
//  NotesViewController.swift
//  TestApp
//
//

import UIKit

class NotesViewController: UIViewController {

    // MARK: - Variables

    var presenter: INotesPresenter?
    
    var notes = [Note]()

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotesManager.getNotes(completionSuccess: { (notes) in
            self.notes = notes
            for note in notes {
                print (note.title)
                print (note.body)
                print (note.timeStamp)
                print ("\n")
            }
        })
    }


}

