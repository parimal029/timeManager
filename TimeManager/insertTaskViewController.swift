//
//  insertTaskViewController.swift
//  TimeManager
//
//  Created by Parimal Patel on 2021-03-24.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class insertTaskViewController: UIViewController {
  
     let db = Firestore.firestore()
    var user = firebase.auth().currentUser;
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var hoursWorkedTextField: UITextField!
    @IBOutlet weak var taskDetailTextView: UITextField!
    @IBOutlet weak var submitTaskButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        Utilities.styleTextField(hoursWorkedTextField)
        Utilities.styleTextField(taskDetailTextView)
        Utilities.styleFilledButton(submitTaskButton)
    }
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        //get user id
       
            
        //set data in firestore
            let userTask :[String : Any] = [
                "Hours Worked" : hoursWorkedTextField.text!,
                "Task Details" : taskDetailTextView.text!,
                "Time Stamp" :  Timestamp(date:Date()),
                "Uid" : Auth.auth().currentUser?.uid
            ]
            //call the api to save the data into the cloud
            
            let docName = (Auth.auth().currentUser?.displayName!)!
        db.collection(user.getUid()).document("user Task").setData(userTask){err in
                if err != nil{
                    print(err)
                }else{
                    print("task added successfully")
                }
                
            }
    }
}
            //save in to database
//            let userData : [String: Any] = ["Hours Worked" : hoursWorked , "Task Detail" : taskDetail]
//            db.collection("users").document(user!.uid).collection("Tasks").addDocument(data: userData){ err in
//                if let err = err{
//                    print("error \(error)")
//                }else{
//                    print("Successfull entered data")
//                }
    ////            }}
//        }
//    }
    //
//    func submitButtonTapped(){
//        guard let hoursWorked = hoursWorkedTextField.text, !hoursWorked.isEmpty else {return}
//        guard let taskDetail = taskDetailTextView.text , !taskDetail.isEmpty else {return}
//        let dataToSave : [String : Any] = ["Hours Worked" : hoursWorked, "Task Detail" : taskDetail]
//        
//    }
//    private func dataTypes() {
//           // [START data_types]
//           let docData: [String: Any] = [
//               "stringExample": "Hello world!",
//             "booleanExample": true,
        //               "numberExample": 3.14159265,
        //               "dateExample": Timestamp(date: Date()),
        //               "arrayExample": [5, true, "hello"],
        //               "nullExample": NSNull(),
        //               "objectExample": [
        //                   "a": 5,
        //                   "b": [
        //                       "nested": "foo"
        //                   ]
        //               ]
        //           ]
        //           db.collection("data").document("one").setData(docData) { err in
        //               if let err = err {
        //                   print("Error writing document: \(err)")
        //               } else {
        //                   print("Document successfully written!")
        //               }
        //           }
        //           // [END data_types]
        //    /*
        //    // MARK: - Navigation
        //
        //    // In a storyboard-based application, you will often want to do a little preparation before navigation
        //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        // Get the new view controller using segue.destination.
        //          // Pass the selected object to the new view controller.


