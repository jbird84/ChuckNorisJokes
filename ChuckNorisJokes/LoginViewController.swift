//
//  LoginViewController.swift
//  Chuck Norris
//
//  Created by Kinney Kare on 2/5/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginButton()
    }
    
    
    fileprivate func setupLoginButton() {
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.backgroundColor = .systemRed
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 0, y: 0, width: 200, height: 35)
        loginButton.layer.cornerRadius = loginButton.frame.size.height / 2
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        let centerXConstraint = loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let centerYConstraint = loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let width = loginButton.widthAnchor.constraint(equalToConstant: 200)
        
        NSLayoutConstraint.activate([centerXConstraint, centerYConstraint, width])
    }
    
    @objc func loginButtonTapped() {
        let auth = Auth.auth()
        auth.signInAnonymously { result, error in
            if let error = error {
                print("DEBUG: error loging in anonymously because \(error.localizedDescription)")
                return
            }
            //If we were able to login successfully
            print("DEBUG: Login was successful!!!")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let containerViewController = storyBoard.instantiateViewController(withIdentifier: "container")
            
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                scene.windows.first?.rootViewController = containerViewController
            }
        }
    }
}
