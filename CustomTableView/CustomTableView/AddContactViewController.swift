//
//  AddContactViewController.swift
//  CustomTableView
//
//  Created by RMP on 11/06/1448 AH.
//

import UIKit

class AddContactViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    
    var delegate: SendDataBackwardProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegates()
        hideKeyboardWhenClickOnScreen()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func delegates() {
        
        nameTextField.delegate = self
        phoneTextField.delegate = self
        
    }
    
    
    // MARK: IBAction functions
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        delegate?.sendData(nameTextField.text ?? "UNKOWN", phoneTextField.text ?? "EMPTY")
        dismiss(animated: true)
        
        
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        print("You clicked on cancel")
        dismiss(animated: true)
        
    }

}

// MARK: textField functions
extension AddContactViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            phoneTextField.becomeFirstResponder()
        }
        return true
    }
    
}


// MARK: keyboard functions
extension AddContactViewController {
    
    
    @objc func hideKayboard() {
        
        view.endEditing(true)
        
    }
    
    func hideKeyboardWhenClickOnScreen() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKayboard))
        view.addGestureRecognizer(tapGesture)
        
    }
    
}

protocol SendDataBackwardProtocol {
    
    func sendData(_ name: String, _ phoneNumber: String)
    
}
