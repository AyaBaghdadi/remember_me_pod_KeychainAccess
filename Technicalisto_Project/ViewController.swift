//
//  ViewController.swift
//
//  Created by Technicalisto.
//

import UIKit
import KeychainAccess

class ViewController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    let keychain = Keychain(service: "com.Technicalisto-Project")

    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.addDoneButtonOnKeyboard()

    }
    
func getPassword(){
DispatchQueue.global().sync {
    
do {
let password = try self.keychain
.authenticationPrompt("Are You want to get saved Email & Passowrd ?")
.get("password")
if password != nil { self.passwordTxt.text = password }
} catch _ {}
            
do {
let email = try self.keychain
.get("email")
if email != nil { self.emailTxt.text = email }
} catch _ {}
    
}}

func savePassword(){
DispatchQueue.global().sync {
do {
try self.keychain
.accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: [.biometryAny])
.set(self.passwordTxt.text ?? "", key: "password")
} catch _ {}
            
do {
try self.keychain
.set(self.emailTxt.text ?? "", key: "email")
} catch _ {}
        
}}
    
func normalGet(){
    
let email = keychain[string: "email"]

let password = keychain[string: "password"]

self.emailTxt.text = email

self.passwordTxt.text = password

}
    
func normalSet(){
do {
try keychain.set(emailTxt.text ?? "" , key: "email")
}
catch let error { print(error) }

do {
try keychain.set(passwordTxt.text ?? "" , key: "password")
}
catch let error { print(error) }
  
}

@IBAction func savePasswordTapped(_ sender: Any) {
    
//    self.savePassword()
    
    self.normalSet()

}
    
    
@IBAction func getPasswordTapped(_ sender: Any) {
    
//    getPassword()
    
    normalGet()
    
}
    
func addDoneButtonOnKeyboard()

{
        
let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
doneToolbar.barStyle = UIBarStyle.default

let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))

let items = NSMutableArray()
items.add(flexSpace)
items.add(done)

doneToolbar.items = items as? [UIBarButtonItem]
doneToolbar.sizeToFit()

self.emailTxt.inputAccessoryView = doneToolbar
self.passwordTxt.inputAccessoryView = doneToolbar

}

@objc func doneButtonAction()
{

    self.emailTxt.resignFirstResponder()
    self.passwordTxt.resignFirstResponder()
    
}
}



