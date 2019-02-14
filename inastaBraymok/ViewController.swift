//
//  ViewController.swift
//  inastaBraymok
//
//  Created by admin on 22/11/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    

    
    @IBAction func loginTapped(_ sender: Any) {
        if let email = emailTextField.text,let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    return
                }
                print("login seccess");
                self.performSegue(withIdentifier: "passEmail", sender: self)
                self.presentProfileScreen();
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! ProfileVC
        vc.email = self.emailTextField.text!
        
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        presentSignUpScreen();
        print("move to sign up");
    }
    
    func presentSignUpScreen(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil) ;
        let signupVC:SignUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC ;
        self.present(signupVC, animated: true, completion: nil);
    }
    func presentProfileScreen(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil) ;
        let tabBarVC:TabBarViewController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController ;
        self.present(tabBarVC, animated: true, completion: nil);
    }
    
   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

