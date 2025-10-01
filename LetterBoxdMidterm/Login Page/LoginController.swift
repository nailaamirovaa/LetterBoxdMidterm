//
//  LoginController.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 13.09.25.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    var userManager = CoreDataManager()
    var user : User?
    var userFavoriteMovies : [FavoriteMovies]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameView.layer.cornerRadius = 18
        passwordView.layer.cornerRadius = 18
        userManager.fetchUserItems()
//        userManager.printUserItems()
        loginButton.layer.cornerRadius = 15
    }    
}

// MARK: - Button Actions

extension LoginController {
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if let user = userManager.items.first(where: {$0.username == username}) {
            if user.password == password {
                let controller = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    if let navController = controller.viewControllers?.first as? UINavigationController,
                           let homeController = navController.viewControllers.first as? HomeController {
                            homeController.username = username
                        UserDefaults.standard.set("\(username)", forKey: "username")
                        userManager.fetchFavorites(for: username)
                        userFavoriteMovies = userManager.userFavorites
                        }
                    if let delegate = windowScene.delegate as? SceneDelegate {
                        delegate.tabbarRoot()
                    }
                }
            } else {
                showWrongPasswordAlert()
            }
        } else {
            showNoUserAlert()
        }
    }
  
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "RegisterController") as! RegisterController
        
        controller.callBack =  { username , password in
            
            self.usernameTextField.text = username
            self.passwordTextField.text = password
        }
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let delegate = windowScene.delegate as? SceneDelegate {
                delegate.navToRegister()
            }
        }
    }
}


// MARK: - Alerts

extension LoginController {
    private func showNoUserAlert() {
        let alert = UIAlertController(
            title: "Login Failed",
            message: "No user found with that username and password.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showWrongPasswordAlert() {
        let alert = UIAlertController(
            title: "Login Failed",
            message: "Incorrect Password",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Try Again", style: .default))
        present(alert, animated: true)
    }
}
