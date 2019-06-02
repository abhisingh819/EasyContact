//
//  EditViewController.swift
//  EasyContact
//
//  Created by Abhinav Singh on 6/2/19.
//  Copyright © 2019 Abhinav. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    var userContactUrl = ""
    var contactDetail:ContactDetail?
    var topics = ["First Name","Last Name","mobile","email"]
    var topicValues = [String]()
    let editContactViewModel = EditContactViewModel()
    var allParameters = false
    var validationMessage = ""
    
    @IBOutlet weak var profilePicImg: UIImageView!
    @IBOutlet weak var tblViewEditContact: UITableView!
    
    @IBOutlet weak var containerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewBottomContraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewEditContact.backgroundColor = UIColor.clear
        if userContactUrl != "", let detail = contactDetail {
            topicValues.append(detail.firstName ?? "")
            topicValues.append(detail.lastName ?? "")
            topicValues.append(detail.phoneNumber ?? "")
            topicValues.append(detail.email ?? "")
        }
        tblViewEditContact.reloadData()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func EditContact(_ sender: Any) {
        //call api
        if userContactUrl == "" {
            addToContacts()
        }else {
            updateContacts()
        }
    }
    
    func getAllParameters() -> [String:AnyObject] {
        
        var parameters:[String:AnyObject] = [:]
        if let favorite = contactDetail?.favorite {
            parameters["favorite"] = favorite as AnyObject
        }
        
        allParameters = false
        validationMessage = ""
        for i in 0..<4 {
            let ndx = IndexPath(row: i, section: 0)
            guard let cell = tblViewEditContact.cellForRow(at: ndx) as? EditTableViewCell else { return [:] }
            switch i {
            case 0:
                if let first = cell.txtContactValue.text, first != "", Validation.containsNonWhiteSpaceCharacters(first) {
                    parameters["first_name"] = first as AnyObject
                } else {
                    allParameters = true
                    validationMessage = "Please fill in the required data in last name"
                }
            case 1:
                if let first = cell.txtContactValue.text, first != "", Validation.containsNonWhiteSpaceCharacters(first) {
                    parameters["last_name"] = first as AnyObject
                } else {
                    allParameters = true
                    validationMessage = "Please fill in the required data in last name"
                }
            case 2:
                if let first = cell.txtContactValue.text, first != "", Validation.containsNumbersOnly(first) {
                    parameters["phone_number"] = first as AnyObject
                } else {
                    allParameters = true
                    validationMessage = "Please use only digits in phone number"
                }
            case 3:
                if let first = cell.txtContactValue.text, first != "", Validation.emailValidationError(first) {
                    parameters["email"] = first as AnyObject
                } else {
                    allParameters = true
                    validationMessage = "Please provide a valid email"
                }
            default:
                print("No value")
            }
        }
        return parameters
    }
    
    func addToContacts(){
        let parameters = getAllParameters()
        if !allParameters {
            callAddApi(parameters: parameters)
        } else {
            showAlert(message: validationMessage, title: "Missing information",redirect: false)
        }
    }
    
    func updateContacts(){
        let parameters = getAllParameters()
        if !allParameters {
            callUpdateApi(parameters: parameters)
        } else {
            showAlert(message: validationMessage, title: "Missing information",redirect: false)
        }
    }
    
    func callUpdateApi(parameters:[String:AnyObject]){
        editContactViewModel.updateContact(userContactUrl,parameter: parameters){[weak self](success:Bool, contact:ContactDetail?) in
            guard let strongSelf = self else { return }
            if success{
                if let contactDetail = contact {
                    DispatchQueue.main.async(execute: { () -> Void in
                        strongSelf.showAlert(message: "Contact with \(contactDetail.phoneNumber ?? "") was updated", title: "Successful", redirect: true)
                    })
                }
            }else {
                DispatchQueue.main.async(execute: { () -> Void in
                    strongSelf.showAlert(message: "No Contacts was updated", title: "There has been an issue",redirect: false)
                })
            }
        }
    }
    
    func callAddApi(parameters:[String:AnyObject]){
        editContactViewModel.addContact(parameters){[weak self](success:Bool, contact:ContactDetail?) in
            guard let strongSelf = self else { return }
            if success{
                if let contactDetail = contact {
                    DispatchQueue.main.async(execute: { () -> Void in
                        strongSelf.showAlert(message: "New contact with \(contactDetail.phoneNumber ?? "") was created", title: "Successful", redirect: true)
                    })
                }
            }else {
                DispatchQueue.main.async(execute: { () -> Void in
                    strongSelf.showAlert(message: "No Contacts was created", title: "There has been an issue",redirect: false)
                })
            }
        }
    }
    
    func showAlert(message:String,title:String,redirect: Bool) {
        let objAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let objAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:
        {[weak self]Void in
            guard let strongSelf = self else { return }
            if redirect {
                strongSelf.navigationController?.popViewController(animated: false)
            }
            
        })
        
        objAlertController.addAction(objAction)
        present(objAlertController, animated: true, completion: nil)
    }
    
    @IBAction func getPhoto(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EditViewController:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let editCell = tblViewEditContact.dequeueReusableCell(withIdentifier: "editCell", for: indexPath) as? EditTableViewCell else { return UITableViewCell() }
        
        configureCell(editCell, IndexPath: indexPath)
        return editCell
    }
    
    func configureCell(_ cell:EditTableViewCell,IndexPath:Foundation.IndexPath)
    {
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.txtContactLbl.text = topics[IndexPath.row]
        if contactDetail != nil {
            cell.txtContactValue.text = topicValues[IndexPath.row]
        }
        
    }
    
    
    
}

