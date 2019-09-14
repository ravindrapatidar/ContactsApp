//
//  ViewController.swift
//  Contacts
//
//  Created by admin on 29/01/19.
//  Copyright © 2019 GoJek. All rights reserved.
//

import UIKit
import Kingfisher

struct ContactListSection {
    let sectionTitle: String
    let contacts: [Contact]
}

class ContactsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var contactsListTableView: UITableView!

    var contactListSections: [ContactListSection] = []

    var selectedContactURL: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Contacts"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getContactsList()
    }

    func getContactsList() {
        NetworkRequestViewModel.sharedInstance.getContacts(urlStr: AppConstants.contactURL, method: "GET", completion: { [weak self] contacts in
              let sortedContacts = contacts.sorted(by: { $0.fullName < $1.fullName })
            
                            self?.contactListSections = []
            
                            let sectionTitles = UILocalizedIndexedCollation.current().sectionTitles
            
                            var calicutaingSections: [ContactListSection] = []
            
            
                            for title in sectionTitles {
                                let contacts = sortedContacts.filter({ $0.fullName.capitalized.hasPrefix(title)})
                                let section = ContactListSection.init(sectionTitle: title, contacts: contacts)
                                calicutaingSections.append(section)
                            }
                            self?.contactListSections = calicutaingSections
            
                            DispatchQueue.main.async {
                                self?.contactsListTableView.reloadData()
                            }
            
        }, failiure: { error in
            
        })
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactListSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactListSections[section].contacts.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if contactListSections[section].contacts.count == 0 {
            return nil
        }
        return contactListSections[section].sectionTitle
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return contactListSections.compactMap({ $0.sectionTitle })
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = contactListSections[indexPath.section].contacts[indexPath.row]

        selectedContactURL = data.url as? String
        performSegue(withIdentifier: "viewContact", sender: nil)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell") as! ContactCell


        let contact = contactListSections[indexPath.section].contacts[indexPath.row]
        cell.contactNameLabel.text = contact.fullName
        cell.contactFavouriteImageView.isHidden = !(contact.favorite ?? false)
        
        
        let placeImage = UIImage.init(named: "placeholder_photo")
        guard let profilePic = contact.profilePic, let url = URL.init(string: profilePic) else {
            return cell
        }
         cell.contactPhotoView.kf.setImage(with: url, placeholder: placeImage, options: [.forceRefresh])

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewContact", let destination = segue.destination as? ContactDetailsViewController {
            destination.contactURL = selectedContactURL
        }
        if segue.identifier == "AddContact", let destination = segue.destination as? AddEditContactViewController {
            
        }
        
    }
    
    
    @IBAction func addContact(_ sender: Any) {
         performSegue(withIdentifier: "AddContact", sender: nil)
    }
}



