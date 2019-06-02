//
//  ContactDetailViewController.swift
//  EasyContact
//
//  Created by Abhinav Singh on 6/2/19.
//  Copyright © 2019 Abhinav. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    var userContactUrl = ""
    
    @IBOutlet weak var profilePicImage: UIImageView!
    
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var favoriteIconImage: UIImageView!
    
    @IBOutlet weak var mobileTxt: UILabel!
    @IBOutlet weak var emailTxt: UILabel!
    @IBOutlet weak var contactActivity: UIActivityIndicatorView!
    
    let contactDetailViewModel = ContactDetailViewModel()
    var contact: ContactDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactActivity.stopAnimating()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callApi()
    }
    
    func callApi() {
        contactDetailViewModel.getContactDetailFromAPI(userContactUrl){[weak self](success:Bool, contact:ContactDetail?) in
            guard let strongSelf = self else { return }
            if success{
                if let contactDetail = contact {
                    strongSelf.contact = contactDetail
                    DispatchQueue.main.async(execute: { () -> Void in
                        strongSelf.emailTxt.text = contactDetail.email ?? ""
                        strongSelf.mobileTxt.text = contactDetail.phoneNumber ?? ""
                        if let fav = contactDetail.favorite {
                            strongSelf.favoriteIconImage.image = fav ? UIImage(named:"favoriteIconSelected.png") : UIImage(named:"favoriteIconUnselected.png")
                        }
                        if let first = contactDetail.firstName, let last = contactDetail.lastName {
                            strongSelf.contactName.text = "\(first) \(last)"
                        }
                        if let profilePic = contactDetail.profilePic {
                            strongSelf.getImage(strongSelf.profilePicImage, url: profilePic)
                        }else {
                            strongSelf.profilePicImage.image = UIImage(named:"placeholderImage.png")
                        }
                    })
                }
            }else {
                DispatchQueue.main.async(execute: { () -> Void in
                    strongSelf.showAlert(message: "No Contacts Detail was fetched", title: "There has been an issue",redirect: false)
                })
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
    
    @IBAction func deleteContact(_ sender: UIButton) {
        self.contactActivity.isHidden = false
        self.contactActivity.startAnimating()
        contactDetailViewModel.deleteContact(userContactUrl){[weak self](success:Bool, contact:ContactDetail?) in
            guard let strongSelf = self else { return }
            if success{
                DispatchQueue.main.async(execute: { () -> Void in
                    strongSelf.contactActivity.stopAnimating()
                    strongSelf.showAlert(message: "Contact Deleted Successfully", title: "Successful",redirect: true)
                })
            }else {
                DispatchQueue.main.async(execute: { () -> Void in
                    strongSelf.contactActivity.stopAnimating()
                    strongSelf.showAlert(message: "No Contacts Detail were deleted", title: "There has been an issue",redirect: false)
                })
            }
        }
    }
    
    @IBAction func backToContacts(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        
    }
    
    @IBAction func editContact(_ sender: Any) {
        
        if let editViewController = Storyboards.mainStoryboard().instantiateViewController(withIdentifier: "editViewController") as? EditViewController {
            editViewController.userContactUrl = userContactUrl
            editViewController.contactDetail = self.contact
            self.navigationController?.pushViewController(editViewController, animated: false)
        }
        
    }
    
    func showAlert(message:String,title:String,redirect:Bool) {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
