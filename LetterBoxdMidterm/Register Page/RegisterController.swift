//
//  RegisterController.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 14.09.25.
//

import UIKit

class RegisterController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var backToLoginButton: UIButton!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    var userManager = CoreDataManager()
    var itemss = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.cornerRadius = 15
        usernameView.layer.cornerRadius = 18
        emailView.layer.cornerRadius = 18
        passwordView.layer.cornerRadius = 18
        
        userManager.fetchItems()
    }
    
    var callBack: ((String , String) -> Void)?

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        if let username = usernameTextField.text , !username.isEmpty,
           let email = emailTextField.text , !email.isEmpty,
           let password = passwordTextField.text , !password.isEmpty {
            let user : UserStruct = .init(username: username, email: email, password: password)
            userManager.saveItem(newUser: user)
            userManager.printItems()
            callBack?(username , password)
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let delegate = windowScene.delegate as? SceneDelegate {
                    delegate.navToLogin()
                }
            }
        }
    }
    
    @IBAction func backToLoginButtonTapped(_ sender: UIButton) {
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let delegate = windowScene.delegate as? SceneDelegate {
                delegate.navToLogin()
            }
        }
    }
}
