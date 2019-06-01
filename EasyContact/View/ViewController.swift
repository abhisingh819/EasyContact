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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        tblViewContact.delegate = self
        callAPI()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func callAPI() {
        contactsViewModel.getContactsFromAPI{[weak self](success:Bool, contacts:[Contacts]) in
            guard let strongSelf = self else { return }
            if success{
                strongSelf.contacts.append(contentsOf: contacts)
                DispatchQueue.main.async(execute: { () -> Void in
                    strongSelf.tblViewContact.reloadData()
                })
            }else {
                strongSelf.showAlert(message: "No Contacts were fetched", title: "There has been an issue")
            }
        }
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
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
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
        cell.contactName.text = ""
        if let first = contacts[IndexPath.row].firstName, let last = contacts[IndexPath.row].lastName {
            cell.contactName.text = "\(first) \(last)"
        }
        
        if let favorite = contacts[IndexPath.row].favorite, favorite == true {
            cell.contactFavoriteImg.isHidden = false
        }else {
            cell.contactFavoriteImg.isHidden = true
        }
        
        if let profile = contacts[IndexPath.row].profilePic {
            getImage(cell.contactProfilePic, url: profile)
        }else {
            cell.contactProfilePic.image = UIImage(named: "placeholderImage.png")
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let contactDetailViewController = Storyboards.mainStoryboard().instantiateViewController(withIdentifier: "contactDetailViewController") as? ContactDetailViewController {
            contactDetailViewController.userContactUrl = self.contacts[indexPath.row].url ?? ""
            self.navigationController?.pushViewController(contactDetailViewController, animated: false)
        }
    }
    


}

