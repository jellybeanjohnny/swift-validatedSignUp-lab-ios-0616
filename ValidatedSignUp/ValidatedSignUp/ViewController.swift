//
//  ViewController.swift
//  ValidatedSignUp
//
//  Created by Flatiron School on 7/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailAddressTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func submitButtonTapped(sender: AnyObject) {
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        guard let text = textField.text else { return false }
        
        var isValidText = false
        
        switch textField {
            
        case firstNameTextField:
            isValidText = isValidName(text)
            if !isValidText { presentErrorAlert(withTitle: "Invalid Name", message: "Must not contain digits", forTextfield: textField) }
            else { lastNameTextField.enabled = true }
            
        case lastNameTextField:
            isValidText = isValidName(text)
            if !isValidText { presentErrorAlert(withTitle: "Invalid Name", message: "Must not contain digits", forTextfield: textField) }
            else { emailAddressTextField.enabled = true }
    
        case emailAddressTextField:
            isValidText = isValidEmail(text)
            if !isValidText { presentErrorAlert(withTitle: "Invalid Email", message: "Must be of format something@something.something", forTextfield: textField) }
            else { usernameTextField.enabled = true }
            
        case usernameTextField:
            isValidText = isValidUsername(text)
            if !isValidText { presentErrorAlert(withTitle: "Invalid Username", message: "Must not contain digits", forTextfield: textField) }
            else { passwordTextField.enabled = true }
            
        case passwordTextField:
            isValidText = isValidPassword(text)
            if !isValidText { presentErrorAlert(withTitle: "Invalid Password", message: "Must contain greater than 6 letters", forTextfield: textField) }
            else { submitButton.enabled = true }
            
        default: break
        }
        
        return isValidText
    }
    
    func isValidName(name: String) -> Bool {
        // must have more than 0 characters, and must not be a digit
        if name.characters.count <= 0 { return false }
        
        let decimalCharacters = NSCharacterSet.decimalDigitCharacterSet()
        
        let decimalRange = name.rangeOfCharacterFromSet(decimalCharacters, options: .LiteralSearch, range: nil)
        
        return decimalRange == nil
    }
    
    func isValidEmail(email: String) -> Bool {
        // a valid email is greater than 0 characters and valid format: something@something.something
        if email.characters.count <= 0 { return false }
    
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9\\._%+-]+@[A-Z0-9\\.-]+\\.[A-Z]", options: .CaseInsensitive)
            let matches = regex.numberOfMatchesInString(email, options: .ReportCompletion, range: NSMakeRange(0, email.characters.count))
    
            print(matches)
            return matches == 1
            
        }
        catch {
            print(error)
        }
        
        return false
    }
    
    func isValidUsername(username: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[A-Za-z]+$", options: .CaseInsensitive)
            let matches = regex.numberOfMatchesInString(username, options: .ReportCompletion, range: NSMakeRange(0, username.characters.count))
            print(matches)
            return matches == 1
        }
        catch { }
        return false
    }
    
    func isValidPassword(password: String) -> Bool {
        return password.characters.count > 6
    }
    
    func presentErrorAlert(withTitle title: String, message: String, forTextfield textField: UITextField) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okayAction = UIAlertAction(title: "Okay", style: .Default, handler: nil)
        let clearAction = UIAlertAction(title: "Clear", style: .Destructive) { (alertAction) in
            textField.text = ""
        }
        
        alertController.addAction(clearAction)
        alertController.addAction(okayAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}

