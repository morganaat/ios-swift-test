//
//  NotesViewController.swift
//  TestApp
//
//

import UIKit

class NotesViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var listTableView: UITableView!
    

    // MARK: - Variables

    var presenter: INotesPresenter?
    var notes = [Note]()
    
    
    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        NotesManager.getNotes(completionSuccess: { (notes) in
            self.notes = notes
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewNoteSegue" {
            let newNoteViewController = segue.destination as! NewNoteViewController
            newNoteViewController.delegate = self
        }
        
    }

}

// MARK: - UITableViewDelegate

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.listTableView.dequeueReusableCell(withIdentifier: "ListCellIdentifier") as! ListTableViewCell

        let note = self.notes[indexPath.row]
        cell.format(note)

        return cell
    }
}

// MARK: - NewNoteViewControllerDelegate

extension NotesViewController: NewNoteViewControllerDelegate {
    
    func didAddNewNote(_ note: Note) {
        NotesManager.getNotes(completionSuccess: { (notes) in
            self.notes = notes
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        })
    }

}

