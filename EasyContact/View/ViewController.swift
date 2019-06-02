//
//  ViewController.swift
//  EasyContact
//
//  Created by Abhinav Singh on 6/1/19.
//  Copyright © 2019 Abhinav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblViewContact: UITableView!
    
    let contactsViewModel = ContactViewModel()
    var contacts = [Contacts]()
    var contactDictionary = [String: [Contacts]]()
    var keys = [String]()
    var alphabets = (97...122).map { "\(Character(UnicodeScalar.init($0)))" }.map { $0.uppercased() }
    
    @IBOutlet weak var contactActivityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        tblViewContact.delegate = self
        self.contactActivityIndicator.stopAnimating()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callAPI()
    }

    func callAPI() {
       
        self.contactActivityIndicator.isHidden = false
        self.contactActivityIndicator.startAnimating()
        contactsViewModel.getContactsFromAPI{[weak self](success:Bool, contacts:[Contacts]) in
            guard let strongSelf = self else { return }
            if success{
                strongSelf.contacts = []
                strongSelf.contacts.append(contentsOf: contacts)
                strongSelf.setContacts()
            }else {
                DispatchQueue.main.async(execute: { () -> Void in
                    strongSelf.showAlert(message: "No Contacts were fetched", title: "There has been an issue")
                    strongSelf.contactActivityIndicator.stopAnimating()
                })
            }
        }
    }
    
    private func setContacts() {
        
        var temp = [String: [Contacts]]() //A temporary array
        for contact in self.contacts {
            if let firstName = contact.firstName, !firstName.isEmpty { //In my case, the firstName is an optional string
                let firstChar = "\(firstName.first!)".uppercased()
                if alphabets.contains(firstChar) {
                    var array = temp[firstChar] ?? []
                    array.append(contact)
                    temp[firstChar] = array
                } else {
                    var array = temp["#"] ?? []
                    array.append(contact)
                    temp["#"] = array
                }
            }
        }
        self.keys = Array(temp.keys).sorted() //Populating and sorting all the keys alphabetically.
        for key in self.keys { self.contactDictionary[key] = temp[key] }
        DispatchQueue.main.async(execute: {[weak self] () -> Void in
            guard let strongSelf = self else { return }
            strongSelf.contactActivityIndicator.stopAnimating()
            strongSelf.tblViewContact.reloadData()
        })
    }
    
    func getImage(_ imageView:UIImageView,url:String)
    {
        let imageUrl = "\(Constants.BASE_URL)\(url)"
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            if let url=URL(string: imageUrl),let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async(execute: { () -> Void in
                    imageView.image = UIImage(data: data)
                })
            }
        })
    }
    
    func showAlert(message:String,title:String) {
        let objAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let objAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:
        {Void in
            
            
        })
        
        objAlertController.addAction(objAction)
        present(objAlertController, animated: true, completion: nil)
    }
    
    @IBAction func addContact(_ sender: Any) {
        
        if let editViewController = Storyboards.mainStoryboard().instantiateViewController(withIdentifier: "editViewController") as? EditViewController {
            self.navigationController?.pushViewController(editViewController, animated: false)
        }
    }
    

}

extension ViewController:UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.contactDictionary.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.keys[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactDictionary[keys[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contactCell = tblViewContact.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        
        configureCell(contactCell, IndexPath: indexPath)
        return contactCell
    }
    
    func configureCell(_ cell:ContactTableViewCell,IndexPath:Foundation.IndexPath)
    {
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        let key = self.keys[IndexPath.section]
        cell.contactName.text = ""
        if let first = self.contactDictionary[key]?[IndexPath.row].firstName, let last = self.contactDictionary[key]?[IndexPath.row].lastName {
            cell.contactName.text = "\(first) \(last)"
        }
        
        if let favorite = self.contactDictionary[key]?[IndexPath.row].favorite, favorite == true {
            cell.contactFavoriteImg.isHidden = false
        }else {
            cell.contactFavoriteImg.isHidden = true
        }
        
        if let profile = self.contactDictionary[key]?[IndexPath.row].profilePic {
            getImage(cell.contactProfilePic, url: profile)
        }else {
            cell.contactProfilePic.image = UIImage(named: "placeholderImage.png")
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let key = self.keys[indexPath.section]
        if let contactDetailViewController = Storyboards.mainStoryboard().instantiateViewController(withIdentifier: "contactDetailViewController") as? ContactDetailViewController {
            guard let url = self.contactDictionary[key]?[indexPath.row].url else { return }
            contactDetailViewController.userContactUrl = url
            self.navigationController?.pushViewController(contactDetailViewController, animated: false)
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.keys
    }

}

