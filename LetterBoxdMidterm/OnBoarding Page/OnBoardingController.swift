//
//  OnBoardingController.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 13.09.25.
//

import UIKit

class OnBoardingController: UIViewController {

    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getStartedButton.layer.cornerRadius = 20
    }

    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let delegate = windowScene.delegate as? SceneDelegate {
                delegate.window?.rootViewController = UINavigationController(rootViewController: controller)
            }
        }
    }
}
