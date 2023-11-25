//
//  ViewController.swift
//  Login
//
//  Created by Katerina on 18/11/2023.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet var titleText: UITextField!
    @IBOutlet var eMailText: UITextField!
    @IBOutlet var envelopImageView: UIImageView!
    @IBOutlet var lineOfEMail: UIView!
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var lockImageView: UIImageView!
    @IBOutlet var lineOfPassword: UIView!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var dontHaveAccountLabel: UILabel!
    @IBOutlet var signupButton: UIButton!
    
    // Properties:
    private let activeColorOlive = UIColor(named: "Olive") ?? UIColor.gray
    private let activeColorRed = UIColor(named: "RedSistem") ?? UIColor.gray
    private var emailUser: String = ""
    private var passwordUser: String = ""
    
    private let mockEmail = "abc@gmail.com"
    private let mockPassword = "123456"
    
    var isValidEmail = false
    var isValidPassword = false

    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.isUserInteractionEnabled = false
        configureButton(button: loginBtn)
        passwordText.delegate = self
        eMailText.delegate = self
        eMailText.becomeFirstResponder()
    }

    @IBAction func loginAction(_ sender: UIButton) {
        eMailText.resignFirstResponder()
        passwordText.resignFirstResponder()
        
        if emailUser.isEmpty {
            setEmailTextFieldStyle(color: activeColorRed)
        }
        
        if passwordUser.isEmpty {
            setPasswordTextFieldStyle(color: activeColorRed)
        }
        
        if emailUser == mockEmail,
           passwordUser == mockPassword {
            performSegue(withIdentifier: "goToHomePage", sender: sender)
        }  else {
            let allert = UIAlertController(
                title: "Error".localized,
                message: "Wrong e-mail or password".localized,
                preferredStyle: .alert)
            let action = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
            allert.addAction(action)
            present(allert, animated: true)
        }
    }
    
    @IBAction func signtupAction(_ sender: UIButton) {
        print("Signup")
    }
    
    private func configureButton(button: UIButton) {
        if button.isUserInteractionEnabled {
            button.backgroundColor = activeColorOlive
            button.layer.shadowColor = activeColorOlive.cgColor
        } else {
            button.backgroundColor = .systemGray5
            button.layer.shadowColor = UIColor.systemGray5.cgColor
        }
        button.layer.shadowOffset = CGSize(width: 0, height: 6)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 8
    }
    
    func setEmailTextFieldStyle(color: UIColor) {
        envelopImageView.tintColor = color
        lineOfEMail.backgroundColor = color
    }
    
    func setPasswordTextFieldStyle(color: UIColor) {
        lockImageView.tintColor = color
        lineOfPassword.backgroundColor = color
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            print("textFieldDidEndEditing")
        
        return true
        }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !text.isEmpty else { return }
        
        if passwordText.text?.count == 0 {
            setPasswordTextFieldStyle(color: .systemGray5)
            isValidPassword = false
        }
        
        switch textField {
        
        case eMailText:
            isValidEmail = check(email: text)
            if isValidEmail {
                emailUser = text
                setEmailTextFieldStyle(color: activeColorOlive)
            } else {
                setEmailTextFieldStyle(color: activeColorRed)
                }
            
        case passwordText:
            isValidPassword = check(password: text)
            if isValidPassword {
                passwordUser = text
                setPasswordTextFieldStyle(color: activeColorOlive)
            } else {
                setPasswordTextFieldStyle(color: activeColorRed)
            }
            
        default:
            print("unknown textField")
        }
        
        if isValidEmail && isValidPassword {
            loginBtn.isUserInteractionEnabled = true
        } else {
            loginBtn.isUserInteractionEnabled = false
        }
        configureButton(button: loginBtn)
    }
    
    private func check(email: String) -> Bool {
        email.contains("@") && email.contains(".")
    }
    
    private func check(password: String) -> Bool {
        return password.count >= 5
    }
   
}

