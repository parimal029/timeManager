//
//  loginViewController.swift
//  TimeManager
//
//  Created by Parimal Patel on 2021-03-18.
//

import UIKit
import FirebaseAuth


class loginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
        
    @IBOutlet weak var passwordTextField: UITextField!
        
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()

        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
         //Hide error label on initial load
        errorLabel.alpha = 0
        
        //style the elements
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        //validate the text fields
        validateField()
        
        //Create Cleaned variables
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else{
                
                let HomeViewController =  self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.HomeViewController) as? HomeViewController
                 
                self.view.window?.rootViewController = HomeViewController
                self.view.window?.makeKeyAndVisible()
            }
            
        }
    }
    func validateField() -> String? {
        //check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill all Fields"
        }
        
        //Check is password is secure
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //password isnt secure enough
            return "Please make sure your password is atleast 8 character, containe a special character and a number."
        }
        
        return nil
    }
}
