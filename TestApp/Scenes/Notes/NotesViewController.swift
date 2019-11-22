//
//  NotesViewController.swift
//  TestApp
//
//

import UIKit

class NotesViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    

    // MARK: - Variables

    var presenter: INotesPresenter?
    var searchIsActive: Bool = false
    var selectedNote: Note?
    var filteredNotes = [Note]()
    var notes: [Note]{
        return NotesManager.notes
    }
    
    
    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        NotesManager.retrieveData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.resetSearch()

        if segue.identifier == "NewNoteSegue" {
            let newNoteViewController = segue.destination as! NewNoteViewController
            newNoteViewController.delegate = self
            newNoteViewController.viewMode = .newNote
        
        } else if segue.identifier == "EditNoteSegue"{
            guard let selectedNote = self.selectedNote else { return }
            let newNoteViewController = segue.destination as! NewNoteViewController
            newNoteViewController.delegate = self
            newNoteViewController.viewMode = .editNote
            newNoteViewController.note = selectedNote
            
        }
        
    }

}

// MARK: - UITableViewDelegate

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchIsActive ? self.filteredNotes.count : self.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.listTableView.dequeueReusableCell(withIdentifier: "ListCellIdentifier") as! ListTableViewCell

        let notes = self.searchIsActive ? self.filteredNotes : self.notes
        let note = notes[indexPath.row]
        cell.format(note)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedNote = self.searchIsActive ? self.filteredNotes[indexPath.row] : self.notes[indexPath.row]
        self.performSegue(withIdentifier: "EditNoteSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        switch editingStyle {
        
        case .delete:
            
            let note = self.searchIsActive ? self.filteredNotes[indexPath.row] : self.notes[indexPath.row]
            
            NotesManager.deleteData(note: note, completionSuccess: {
                
                DispatchQueue.main.async {
                    
                    if self.searchIsActive {
                        self.updateFilteredList()
                    }
                    self.listTableView.reloadData()
                }
            })
        
        default:
            break
        }
    }

}

// MARK: - UISearchBarDelegate

extension NotesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resetSearch()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        self.searchIsActive = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.searchIsActive = false
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.updateFilteredList()
        self.listTableView.reloadData()
    }
    
    func resetSearch() {
        self.searchBar.searchTextField.resignFirstResponder()
        self.searchBar.searchTextField.text = ""
        self.searchIsActive = false
        self.listTableView.reloadData()
    }
    
    func updateFilteredList() {
        guard let text = self.searchBar.text else { return }
        if text.isEmpty || text == "" {
            self.searchIsActive = false
        } else {
            self.filteredNotes = notes.filter({$0.noteText.lowercased().contains(text.lowercased())})
            self.searchIsActive = true
        }
    }
    
}

// MARK: - NewNoteViewControllerDelegate

extension NotesViewController: NewNoteViewControllerDelegate {
    
    func didUpdateNotes() {
        self.listTableView.reloadData()
        
    }

}

