//
//  ProfileVC.swift
//  inastaBraymok
//
//  Created by admin on 22/11/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import FirebaseUI
import FirebaseStorage
import FirebaseDatabase

class ProfileVC: UIViewController {

    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    var databaseRef:DatabaseReference!
    
    
    var user: User!
    
    var email = ""
    
    func downloadImageTest(){
        let storageRef = Storage.storage()
        let imageRef = storageRef.reference(withPath: "profileImages/aa+aae@gmail.com")
        let imageView: UIImageView = self.profileImageView
        let placeholderImage = UIImage(named: "placeholder.jpg")
        imageView.sd_setImage(with: imageRef,placeholderImage: placeholderImage)
 
    }
    
    func setUser(){
        let userId = User.usersId[email]
        self.databaseRef.child(userId!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let userName = value?["name"] as? String ?? ""
            self.user = User(id: userId!, fullname: userName, email: self.email, password: "123456", profileImage: " ")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseRef = Database.database().reference()
        setUser()
        print("test begin")
        downloadImageTest()
        print("test end")
        // Do any additional setup after loading the view.
        label.text! = email
       
    }

}
