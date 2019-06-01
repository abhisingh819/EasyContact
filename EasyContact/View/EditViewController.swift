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

