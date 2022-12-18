//
//  HomeViewController.swift
//  ChuckNorisJokes
//
//  Created by Kinney Kare on 12/17/22.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class HomeViewController: UIViewController {

    let jokeLabel = UILabel()
    let getJokeButton = UIButton()
    weak var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .secondarySystemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapMenuButton))
        setupJokeLabel()
        setupGetJokeButton()
    }
    
    private func setupJokeLabel() {
        jokeLabel.text = ""
        view.addSubview(jokeLabel)
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        jokeLabel.numberOfLines = 0
        jokeLabel.lineBreakMode = .byWordWrapping
        jokeLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        jokeLabel.textColor = .systemRed
        let centerXConstraint = jokeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let topConstraint = jokeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        let widthConstraint = jokeLabel.widthAnchor.constraint(equalToConstant: 300)

        NSLayoutConstraint.activate([centerXConstraint, widthConstraint, topConstraint])
    }
    
    private func setupGetJokeButton() {
        getJokeButton.setTitle("   Random Chuck Norris Joke   ", for: .normal)
        getJokeButton.backgroundColor = .systemIndigo
        view.addSubview(getJokeButton)
        getJokeButton.frame = CGRect(x: 0, y: 0, width: 200, height: 35)
        getJokeButton.layer.cornerRadius = getJokeButton.frame.size.height / 2
        getJokeButton.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXConstraint = getJokeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let bottomConstraint = getJokeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        
        NSLayoutConstraint.activate([centerXConstraint, bottomConstraint])
    }

    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }

}

