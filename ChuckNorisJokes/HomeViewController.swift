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
    let gifImageView = UIImageView()
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
        jokeLabel.textColor = .systemIndigo
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
        getJokeButton.addTarget(self, action: #selector(getJoke), for: .touchUpInside)
        let centerXConstraint = getJokeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let bottomConstraint = getJokeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        
        NSLayoutConstraint.activate([centerXConstraint, bottomConstraint])
    }
    
    private func setupGifView() {
        view.addSubview(gifImageView)
        gifImageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 20, height: 300)
        gifImageView.contentMode = .scaleAspectFill
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        gifImageView.backgroundColor = .systemTeal
        
        let centerXConstraint = gifImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let bottomConstraint = gifImageView.bottomAnchor.constraint(equalTo: getJokeButton.topAnchor, constant: 0)
        NSLayoutConstraint.activate([centerXConstraint, bottomConstraint])
    }

    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
    
    @objc func getJoke() {
        APIManager().fetchData { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let joke):
                DispatchQueue.main.async {
                    this.jokeLabel.text = joke.value.capitalizedSentence
                }
            }
        }
        APIManager().fetchGifData { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let gif):
                    var gifURL = ""
                    for url in gif.results {
                        gifURL = "\(url.url)"
                    }
                this.downloadGif(url: gifURL)
                }
            }
        }
   
    private func downloadGif(url: String) {
        let imageUrlString = url
        guard let imageUrl = URL(string: imageUrlString) else { return }
        let task = URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
                guard let this = self else { return }
                if let error = error {
                    print("Woww an ERROR:")
                    print(error)
                    print("WOW  A local description")
                    print(error.localizedDescription)
                } else if let data = data {
                let theGif = UIImage.gifImageWithData(data)
                DispatchQueue.main.async {
                    this.gifImageView.image = theGif
                    this.setupGifView()
                }
                }
            }
    }

}
