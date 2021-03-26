//
//  SignUpViewController.swift
//  TimeManager
//
//  Created by Parimal Patel on 2021-03-18./Users/parimal/Desktop/TimeManager/TimeManager/SignUpViewController.swift
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements(){
        //hide error label on initial load
        errorLabel.alpha = 0
        
        //style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
    }
    
    //validate and check the data is correct.
    //If everything is correct this method return nill otherwise it returns an error message as string
    func validateField() -> String? {
        //check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
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
    
    @IBAction func signUpTapped(_ sender: Any) {
        //validate the fields
        let error = validateField()
        
        if error != nil {
            //error found
            showError(error!)
        }else{
            //create cleaned version of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        //create the user
            Auth.auth().createUser(withEmail:email, password: password ) { (result, err) in
                if let err = err{
                    //there was an error in creating the user
                    self.showError("Error Creating User")
                }
                else{
                    //user was created succesfully now store the first name and last name
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname":firstName,"lastname":lastName,"uid":result!.user.uid]) { (error) in
                        if error != nil{
                            //show error message
                            self.showError("User already exist!")
                        }
                    }
                    
                    //transition to the home screen
                    self.transitionToHome()
                }
            }
        
      
        
        }
}
    
    func showError(_ message : String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func transitionToHome(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "LoginVC")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
       
        
//       let loginViewController =  storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? loginViewController
//
//        view.window?.rootViewController = loginViewController
//        view.window?.makeKeyAndVisible()
    }
}
