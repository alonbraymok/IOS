//
//  SignUpVC.swift
//  inastaBraymok
//
//  Created by admin on 22/11/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseStorage


class SignUpVC: UIViewController,UIImagePickerControllerDelegate ,UINavigationControllerDelegate {

    var userRef: DatabaseReference!
    
    let imagePicker = UIImagePickerController();
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
  
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userRef = Database.database().reference().child("users")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ProfileVC
        vc.email = self.emailTextField.text!
        
    }
    
    @IBAction func addProfilePic(_ sender: UIButton) {
    print("test")
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            profileImageView.image = image
        }
        else
        {
            print("Error upload the image");
            //Error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func createTapped(_ sender: Any) {
        if passwordTextField.text != confirmPasswordTextField.text {
            
            print("Error with unmatch password");
            return;
        }
        
        print(emailTextField.text!)
        print(passwordTextField.text!)
        
        if let email = emailTextField.text , let password = passwordTextField.text {
            print(email)
            print(password)
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let firebaseError = error {
                    print("------------")
                    print(firebaseError.localizedDescription);
                    print("------------")
                    return
                }
                
                print("user been sign up seccesfully");
            }
        }
        
        
        let key = userRef.childByAutoId().key
        User.usersId["\(emailTextField.text!)"] = key
        print("userId list as update")
        
        let user = [ "id":key,
                     "name": nameTextField.text! as String,
                     "email" : emailTextField.text! as String,
                     "password" : passwordTextField.text! as String ]
        self.userRef.child("\(key!)").setValue(user);
        print("user data upload to firebase")
        self.saveImageProfile();
        self.performSegue(withIdentifier: "passEmail", sender: self)
        self.presentProfileScreen();
    }

    func saveImageProfile(){
        let storage = Storage.storage()
        var data = Data()
        data = UIImagePNGRepresentation(profileImageView.image!)!
        
        let storageRef = storage.reference()
        let imageRef = storageRef.child("profileImages/\(emailTextField.text!)ProfileImage")
        _ = imageRef.putData(data, metadata: nil, completion: {(metadata, error) in
            if error == nil {
                print("-----------------------------")
                
                print("-----------------------------")
                imageRef.downloadURL { (url, error) in
                    if error != nil{
                        print("feild get image url")
                        return
                    }
                    print("userURL----------------")
                    print(url!);
                    print("userURL----------------")
                    print("profile image been successfuly upload")
                    
                }
            return
        }
                     
    })
    }
    
    
    func presentProfileScreen(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil) ;
        let tabBarVC:TabBarViewController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController ;
        self.present(tabBarVC, animated: true, completion: nil);
    }

    
    
    
}
